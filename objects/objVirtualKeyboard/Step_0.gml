/// objVirtualKeyboard – Step

// -------- Navigation (D-Pad / Arrows) --------
if (keyboard_check_pressed(vk_up)   || gamepad_button_check_pressed(0,gp_padu )) selected_row = max(0, selected_row-1);
if (keyboard_check_pressed(vk_down) || gamepad_button_check_pressed(0,gp_padd)) selected_row = min(4, selected_row+1);
if (keyboard_check_pressed(vk_left) || gamepad_button_check_pressed(0,gp_padl)) selected_col = max(0, selected_col-1);
if (keyboard_check_pressed(vk_right)|| gamepad_button_check_pressed(0,gp_padr)) selected_col = min(9, selected_col+1);

if (keyboard_lastkey != vk_nokey || gamepad_button_check_pressed(0,gp_padu) || gamepad_button_check_pressed(0,gp_padd) ||
    gamepad_button_check_pressed(0,gp_padl) || gamepad_button_check_pressed(0,gp_padr))
{
    if (audio_exists(sndSelect)) audio_play_sound(sndSelect,0,false);
}

// -------- Add / Backspace ----------
if (keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(0,gp_face1)) {
    var ch = keyboard_grid[selected_row*10 + selected_col];
    if (ch == "<") {
        if (string_length(current_string) > 0) current_string = string_delete(current_string,string_length(current_string),1);
    } else if (ch == "OK") {
        global.ui_overlay_active = false;
        instance_destroy();
    } else if (string_length(current_string) < max_chars) {
        current_string += ch;
    }
    if (audio_exists(sndPressed)) audio_play_sound(sndPressed,0,false);
}

//  Backspace with controller B or keyboard Backspace
if (gamepad_button_check_pressed(0,gp_face2) || keyboard_check_pressed(vk_backspace)) {
    if (string_length(current_string) > 0) current_string = string_delete(current_string,string_length(current_string),1);
    if (audio_exists(sndPressed)) audio_play_sound(sndPressed,0,false);
}

// -------- Real keyboard typing ----------
if (keyboard_check_pressed(vk_anykey)) {
    var kc = keyboard_lastkey;
    if (kc == vk_backspace) {
        if (string_length(current_string) > 0) current_string = string_delete(current_string,string_length(current_string),1);
    } else if (kc == vk_enter) {
        global.ui_overlay_active = false;
        instance_destroy();
    } else if (string_length(current_string) < max_chars) {
        current_string += keyboard_lastchar;
    }
}

// -------- Live reflect into roster ----------
if (instance_exists(objTeamRosterEditor)) with (objTeamRosterEditor) {
    if (other.target_row < 0) {
        var idx = -1 - other.target_row;
        switch (idx) {
            case 0: team_name =  other.current_string; break;
            case 1: team_city =  other.current_string; break;
            case 2: team_abbr =  other.current_string; break;
        }
    } else {
        grid_data[other.target_row].fields[other.target_col] = other.current_string;
    }
}

// -------- Close with Start / Esc ----------
if (gamepad_button_check_pressed(0,gp_start) || keyboard_check_pressed(vk_escape)) {
    global.ui_overlay_active = false;
    instance_destroy();
}
