// objPauseMenu - Step Event

// --- Fading logic ---
if (!fading_out && fade < 1) {
    fade = min(fade + fade_speed, 1);
} else if (fading_out && fade > 0) {
    fade = max(fade - fade_speed, 0);
    if (fade <= 0) {
        // Finish fade out: do pending action
        if (fade_wait == 1) { // Main Menu
            with (all) if (object_index != objMenuPause) instance_destroy();
            global.game_paused = false;
            room_goto(RM_TeamSelect);
        } else if (fade_wait == 2) { // Exit
            game_end();
        } else if (fade_wait == 3) { // Unpause
            instance_destroy();
            global.game_paused = false;
        }
    }
    exit; // skip the rest of step event during fade-out
}

// --- Skip input if fading out or not fully faded in ---
if (fading_out || fade < 1) exit;

// --- Navigation (keyboard/gamepad) ---
var up = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W")) || gamepad_button_check_pressed(0, gp_padu);
var down = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S")) || gamepad_button_check_pressed(0, gp_padd);
var select = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_face1);
var unpause = keyboard_check_pressed(vk_escape) || gamepad_button_check_pressed(0, gp_start);

// Mouse hover for "hovered" effect (optional)
hovered = -1;
var btn_x      = display_get_gui_width()/2 - 120;
var btn_y_base = 180;
var btn_w      = 240;
var btn_h      = 55;
var btn_gap    = 18;

for (var i = 0; i < array_length(menu_buttons); ++i) {
    var this_btn_y = btn_y_base + i * (btn_h + btn_gap);
    if (point_in_rectangle(window_mouse_get_x(), window_mouse_get_y(), btn_x, this_btn_y, btn_x + btn_w, this_btn_y + btn_h)) {
        hovered = i;
        if (_prev_hovered != hovered) {
            audio_play_sound(sndSelect, 0, false);
            _prev_hovered = hovered;
        }
        if (mouse_check_button_pressed(mb_left)) selected = i;
    }
}

// Up/down navigation (sound on change)
if (up) {
    selected = (selected + array_length(menu_buttons) - 1) mod array_length(menu_buttons);
    if (_prev_selected != selected) audio_play_sound(sndSelect, 0, false);
    _prev_selected = selected;
}
if (down) {
    selected = (selected + 1) mod array_length(menu_buttons);
    if (_prev_selected != selected) audio_play_sound(sndSelect, 0, false);
    _prev_selected = selected;
}

// Mouse click selection
if (mouse_check_button_pressed(mb_left) && hovered != -1) {
    selected = hovered;
    select = true; // trigger selection for mouse clicks
}

// Unpause (esc/start)
if (unpause && !just_unpaused) {
    audio_play_sound(sndPressed, 0, false);
    fading_out = true;
    fade_wait = 3; // Unpause action
    just_unpaused = true;
    exit;
}
if (!unpause) just_unpaused = false;

// --- Menu actions ---
if (select) {
    audio_play_sound(sndPressed, 0, false);
	
    switch (selected) {
        case 0:
            // TOGGLE FULLSCREEN
            window_set_fullscreen(!window_get_fullscreen());
			alarm[0]=10
            break;
        case 1:
            // MAIN MENU: Fade out, then kill all, then goto menu
            fading_out = true;
            fade_wait = 1;
			audio_stop_all();
			room_goto(RM_TeamSelect);
            break;
        case 2:
            // EXIT TO DESKTOP: Fade out, then exit
            fading_out = true;
            fade_wait = 2;
			game_end();
            break;
    }
}
// objGameController - Step Event

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
