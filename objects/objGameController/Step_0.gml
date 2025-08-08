// objGameController - Step Event

// Ensure objPauseMenu object is registered
dummy = objMenuPause;

// Only listen if pause menu is NOT already open
if (!instance_exists(objMenuPause)) {
    var pause_pressed =
        keyboard_check_pressed(vk_escape) ||
        keyboard_check_pressed(vk_enter) ||
        gamepad_button_check_pressed(0, gp_start);

    if (pause_pressed) {
        instance_create_layer(0, 0, "GUI", objMenuPause);
    }
}


/* ----------------------------------------------------------
   1.  Ensure a pad index (so hot-plugging works)
---------------------------------------------------------- */
if (gamepad_index == -1 && gamepad_is_connected(0)) gamepad_index = 0;
if (gamepad_index != -1 && !gamepad_is_connected(gamepad_index)) gamepad_index = -1;

/* ----------------------------------------------------------
   2.  MOVEMENT  (left stick, D-pad, WASD / arrows)
---------------------------------------------------------- */
var mx = 0, my = 0;

if (gamepad_index != -1)
{
    mx = gamepad_axis_value(gamepad_index, gp_axislh);
    my = gamepad_axis_value(gamepad_index, gp_axislv);
    // D-Pad overrides stick if pressed
    if (gamepad_button_check(gamepad_index, gp_padu)) my = -1;
    if (gamepad_button_check(gamepad_index, gp_padd)) my =  1;
    if (gamepad_button_check(gamepad_index, gp_padl)) mx = -1;
    if (gamepad_button_check(gamepad_index, gp_padr)) mx =  1;
}

if (keyboard_check(vk_left) || keyboard_check(ord("A"))) mx = -1;
if (keyboard_check(vk_right)|| keyboard_check(ord("D"))) mx =  1;
if (keyboard_check(vk_up)   || keyboard_check(ord("W"))) my = -1;
if (keyboard_check(vk_down) || keyboard_check(ord("S"))) my =  1;

global.qb_move_x = clamp(mx, -1, 1);
global.qb_move_y = clamp(my, -1, 1);

/* ----------------------------------------------------------
   3.  HIKE  (Enter or A / south button)
---------------------------------------------------------- */
var hike_now = false;

if (keyboard_check_pressed(vk_enter)) hike_now = true;
if (gamepad_index != -1 && gamepad_button_check_pressed(gamepad_index, gp_face1))
    hike_now = true;

global.qb_hike = hike_now;

/* ----------------------------------------------------------
   4.  THROW  (number 1-5 or game-pad buttons)
   We only set it the *instant* the button is pressed – the QB
   consumes it and resets it to -1.
---------------------------------------------------------- */
global.throw_pressed = -1;

///  keys 1-5
if (keyboard_check_pressed(ord("1"))) global.throw_pressed = 0;
if (keyboard_check_pressed(ord("2"))) global.throw_pressed = 1;
if (keyboard_check_pressed(ord("3"))) global.throw_pressed = 2;
if (keyboard_check_pressed(ord("4"))) global.throw_pressed = 3;
if (keyboard_check_pressed(ord("5"))) global.throw_pressed = 4;

///  pad mapping (A,B,X,Y,L-Bumper  → WR1-5)
if (gamepad_index != -1)
{
    if (gamepad_button_check_pressed(gamepad_index, gp_face1))   global.throw_pressed = 0;
    if (gamepad_button_check_pressed(gamepad_index, gp_face2))   global.throw_pressed = 1;
    if (gamepad_button_check_pressed(gamepad_index, gp_face3))   global.throw_pressed = 2;
    if (gamepad_button_check_pressed(gamepad_index, gp_face4))   global.throw_pressed = 3;
    if (gamepad_button_check_pressed(gamepad_index, gp_shoulderl)) global.throw_pressed = 4;
}

// === System Functions ===
if (keyboard_check_pressed(vk_tab)) window_set_fullscreen(!window_get_fullscreen());
if (keyboard_check_pressed(ord("R"))) game_restart();
if (keyboard_check_pressed(vk_escape)) game_end();
