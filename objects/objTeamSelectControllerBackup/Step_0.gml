// --- Step Event: objTeamSelectController ---
// Make sure these variables exist in Create Event!
/*
selected = 0;
hovered = -1;
edit_team_index = 0;
menu_buttons = ["Quick Play", "Online Play", "Franchise", "Create Team", "Edit Team", "Settings", "Exit"];
// teams is set dynamically in Create
*/

var menu_len = array_length(menu_buttons);

// MOUSE SELECTION
var mouse_x_gui = device_mouse_x_to_gui(0);
var mouse_y_gui = device_mouse_y_to_gui(0);

// Menu item rects
var btn_x = 540;
var btn_w = 320;
var btn_h = 54;
var btn_y_start = 160;
var btn_gap = 20;

// Reset hover each step
hovered = -1;

// Check if mouse is over a button
for (var i = 0; i < menu_len; ++i) {
    var rect_y = btn_y_start + i * (btn_h + btn_gap);
    if (mouse_x_gui > btn_x && mouse_x_gui < btn_x + btn_w
        && mouse_y_gui > rect_y && mouse_y_gui < rect_y + btn_h) {
        hovered = i;
    }
}

// --- INPUT: Keyboard & Gamepad Navigation ---
var move_up = keyboard_check_pressed(vk_up) || gamepad_button_check_pressed(0, gp_padu);
var move_down = keyboard_check_pressed(vk_down) || gamepad_button_check_pressed(0, gp_padd);
var select_pressed = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(0, gp_face1); // "A" on xbox, "X" on ps

// Move up/down
if (move_up) {
    selected = (selected - 1 + menu_len) mod menu_len;
    audio_play_sound(sndSelect, 1, false);
}
if (move_down) {
    selected = (selected + 1) mod menu_len;
    audio_play_sound(sndSelect, 1, false);
}

// Mouse click for selection
if (mouse_check_button_pressed(mb_left) && hovered != -1) {
    selected = hovered;
    audio_play_sound(sndSelect, 1, false);
    // Selection happens on mouse release below
}

// --- "Edit Team" Left/Right/Click Team Change ---
if (menu_buttons[selected] == "Edit Team") {
    var team_ct = array_length(teams);

    // Keyboard/gamepad arrows to scroll teams
    if (keyboard_check_pressed(vk_left) || gamepad_button_check_pressed(0, gp_padl)) {
        edit_team_index = (edit_team_index - 1 + team_ct) mod team_ct;
        audio_play_sound(sndSelect, 1, false);
    }
    if (keyboard_check_pressed(vk_right) || gamepad_button_check_pressed(0, gp_padr)) {
        edit_team_index = (edit_team_index + 1) mod team_ct;
        audio_play_sound(sndSelect, 1, false);
    }
    // Mouse arrows handled in Draw GUI with click checks
}

// --- ACTIVATE BUTTON (Keyboard/gamepad or mouse release) ---
if (select_pressed || (mouse_check_button_released(mb_left) && hovered == selected)) {
    switch (menu_buttons[selected]) {
        case "Quick Play":
            audio_play_sound(sndPressed, 1, false);
            room_goto(rGame)
            show_debug_message("[MENU] Quick Play selected");
            break;
        case "Online Play":
            audio_play_sound(sndPressed, 1, false);
            // TODO: room_goto(OnlinePlay)
            show_debug_message("[MENU] Online Play selected");
            break;
        case "Franchise":
            audio_play_sound(sndPressed, 1, false);
            // TODO: room_goto(rmFranchise);
            show_debug_message("[MENU] Franchise selected");
            break;

        case "Create Team":
            audio_play_sound(sndPressed, 1, false);
            // Prompt for name, or generate a unique name
            var new_team_name = "New Team " + string(ds_map_size(global.team_palettes) + 1);
            global.team_edit_name = new_team_name;

            // Clone palette from first team or use default (make sure it's a copy, not a reference!)
            var keys = scr_safe_ds_map_keys(global.team_palettes);
            var pal_size = global.palette_size; // or however many colors per palette
            var base_palette = array_create(pal_size, c_white);
            if (array_length(keys) > 0) {
                array_copy(base_palette, 0, global.team_palettes[? keys[0]], 0, pal_size);
            }
            global.team_palettes[? new_team_name] = base_palette;
            global.current_pal = array_create(pal_size, 0);
            array_copy(global.current_pal, 0, base_palette, 0, pal_size);

            room_goto(rmTeamEditor);
            show_debug_message("[MENU] Create New Team: " + string(new_team_name));
            break;

        case "Edit Team":
            audio_play_sound(sndPressed, 1, false);
            global.team_edit_name = teams[edit_team_index];
            var pal_size = global.palette_size;

            // Deep copy for editing!
            if (ds_map_exists(global.team_palettes, global.team_edit_name)) {
                global.current_pal = array_create(pal_size, 0);
                array_copy(global.current_pal, 0, global.team_palettes[? global.team_edit_name], 0, pal_size);
            } else {
                global.current_pal = array_create(pal_size, c_white);
            }
            room_goto(rmTeamEditor);
            show_debug_message("[MENU] Edit Team: " + string(global.team_edit_name));
            break;

        case "Settings":
            audio_play_sound(sndPressed, 1, false);
            room_goto(rmSettings);//nothing in there yet 
            show_debug_message("[MENU] Settings selected");
            break;
        case "Exit":
            audio_play_sound(sndPressed, 1, false);
            show_debug_message("[MENU] Exit selected");
            game_end();
            break;
    }
}
