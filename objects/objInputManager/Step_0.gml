/// @desc Input Manager – Step   (2025-06-22 21:10 CDT)

/* ─────────────────────────────────────────────
   0.  Game-pad presence
───────────────────────────────────────────── */
var pad_ok = gamepad_is_connected(0);

/* ─────────────────────────────────────────────
   1.  MOVEMENT AXES
   QB frozen until the ball is hiked or play_live
───────────────────────────────────────────── */
if (global.play_active || objQB.hiked)
{
    /* keyboard WASD */
    global.qb_move_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
    global.qb_move_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));

    /* left stick / D-Pad overrides */
    if (pad_ok)
    {
        global.qb_move_x = gamepad_axis_value(0, gp_axislh);
        global.qb_move_y = gamepad_axis_value(0, gp_axislv);

        if (gamepad_button_check(0, gp_padl)) global.qb_move_x = -1;
        if (gamepad_button_check(0, gp_padr)) global.qb_move_x =  1;
        if (gamepad_button_check(0, gp_padu)) global.qb_move_y = -1;
        if (gamepad_button_check(0, gp_padd)) global.qb_move_y =  1;
    }
}
else
{
    global.qb_move_x = 0;
    global.qb_move_y = 0;
}

/* ─────────────────────────────────────────────
   2.  HIKE BUTTON   (keyboard “R”  or  LB)
───────────────────────────────────────────── */
global.qb_hike = keyboard_check_pressed(ord("R"));
if (pad_ok && gamepad_button_check_pressed(0, gp_shoulderl))
    global.qb_hike = true;

/* ─────────────────────────────────────────────
   3.  AUDIBLE / PATH-ASSIGN MODE
   Hold RB pre-snap → pick WR (A/B/X/Y/LB)
   → choose new route (D-Pad / LB).
───────────────────────────────────────────── */
if (!global.play_active && pad_ok && gamepad_button_check(0, gp_shoulderr))
{
    global.path_assign_mode = true;

    /* select WR index */
    if (gamepad_button_check_pressed(0, gp_face1))    global.path_wr_index = 0; // A
    if (gamepad_button_check_pressed(0, gp_face2))    global.path_wr_index = 1; // B
    if (gamepad_button_check_pressed(0, gp_face3))    global.path_wr_index = 2; // X
    if (gamepad_button_check_pressed(0, gp_face4))    global.path_wr_index = 3; // Y
    if (gamepad_button_check_pressed(0, gp_shoulderl))global.path_wr_index = 4; // LB

    /* choose route */
    var new_path = "";
    if (global.path_wr_index != -1)
    {
        if (gamepad_button_check_pressed(0, gp_padu)) new_path = "Path1";
        if (gamepad_button_check_pressed(0, gp_padr)) new_path = "Path2";
        if (gamepad_button_check_pressed(0, gp_padd)) new_path = "Path3";
        if (gamepad_button_check_pressed(0, gp_padl)) new_path = "Path4";
        if (gamepad_button_check_pressed(0, gp_shoulderl)) new_path = "Path5";

        if (new_path != "")
        {
            /* apply to selected WR */
            with (objWRParent) if (wr_index == global.path_wr_index)
            {
                assigned_path = new_path;
                path_pending  = true;      // starts after hike
                flash_timer   = 18;        // white flash
            }

            /* 🔊 confirmation beep */
            audio_play_sound(sndSelect, 1, false);

            /* exit assign mode */
            global.path_assign_mode = false;
            global.path_wr_index    = -1;
        }
    }
}
else
{
    global.path_assign_mode = false;
    global.path_wr_index    = -1;
}

/* ─────────────────────────────────────────────
   4.  THROW BUTTONS (only when NOT in assign mode)
───────────────────────────────────────────── */
global.throw_pressed = -1;

if (!global.path_assign_mode)
{
    /* keyboard 1-5 */
    if (keyboard_check_pressed(ord("1"))) global.throw_pressed = 0;
    if (keyboard_check_pressed(ord("2"))) global.throw_pressed = 1;
    if (keyboard_check_pressed(ord("3"))) global.throw_pressed = 2;
    if (keyboard_check_pressed(ord("4"))) global.throw_pressed = 3;
    if (keyboard_check_pressed(ord("5"))) global.throw_pressed = 4;

    /* game-pad buttons */
    if (pad_ok)
    {
        if (gamepad_button_check_pressed(0, gp_face1)) global.throw_pressed = 0; // A
        if (gamepad_button_check_pressed(0, gp_face2)) global.throw_pressed = 1; // B
        if (gamepad_button_check_pressed(0, gp_face3)) global.throw_pressed = 2; // X
        if (gamepad_button_check_pressed(0, gp_face4)) global.throw_pressed = 3; // Y

        /* RB tap DURING play → WR5 */
        if (gamepad_button_check_pressed(0, gp_shoulderr) && global.play_active)
            global.throw_pressed = 4;
    }
}

/* ─────────────────────────────────────────────
   5.  SYSTEM / DEBUG KEYS
───────────────────────────────────────────── */
if (keyboard_check_pressed(vk_tab))     window_set_fullscreen(!window_get_fullscreen());
if (keyboard_check_pressed(ord("R")))   game_restart();
if (keyboard_check_pressed(vk_escape))  game_end();
