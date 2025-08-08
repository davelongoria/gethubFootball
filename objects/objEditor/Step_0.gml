// --- objEditor Step Event ---
// Handle input for team info
if (mouse_check_button_pressed(mb_left)) {
    var mx = mouse_x, my = mouse_y;
    for (var i = 0; i < 3; i++) {
        var field_ypos = y + offset_y[i], field_xpos = x + box_x;
        if (point_in_rectangle(mx, my, field_xpos, field_ypos, field_xpos+box_w, field_ypos+box_h)) {
            active_field = i;
            switch (active_field) {
                case 0: keyboard_string = team_name; break;
                case 1: keyboard_string = team_city; break;
                case 2: keyboard_string = team_abbr; break;
            }
        }
    }
}

// Tab/Enter to move to next field
if (keyboard_check_pressed(vk_tab) || keyboard_check_pressed(vk_enter)) {
    active_field = (active_field + 1) mod 3;
    switch (active_field) {
        case 0: keyboard_string = team_name; break;
        case 1: keyboard_string = team_city; break;
        case 2: keyboard_string = team_abbr; break;
    }
}

// Clamp input string, restrict chars
var input_str = keyboard_string;
switch (active_field) {
    case 0:
    case 1:
        input_str = "";
        var s = keyboard_string;
        for (var i = 1; i <= string_length(s); i++) {
            var c = string_copy(s, i, 1);
            if (string_count(c, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 ") > 0)
                input_str += c;
            if (string_length(input_str) >= max_length[active_field]) break;
        }
        break;
    case 2:
        input_str = "";
        var s = string_upper(keyboard_string);
        for (var i = 1; i <= string_length(s); i++) {
            var c = string_copy(s, i, 1);
            if (string_count(c, "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789") > 0)
                input_str += c;
            if (string_length(input_str) >= max_length[active_field]) break;
        }
        break;
}

// Save values
switch (active_field) {
    case 0: team_name = input_str; break;
    case 1: team_city = input_str; break;
    case 2: team_abbr = input_str; break;
}

// Sync to global for saves
global.team_name = team_name;
global.team_city = team_city;
global.team_abbr = team_abbr;
