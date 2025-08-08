/// objTeamRosterEditor - Step Event

if (!variable_global_exists("ui_overlay_active")) global.ui_overlay_active = false;

// Skip input if UI overlay is active
if (global.ui_overlay_active) exit;

// --- Navigation Inputs ---
if (keyboard_check_pressed(vk_down) || gamepad_button_check_pressed(0, gp_padd)) {
    if (active_row < array_length(grid_data) - 1) {
        active_row++;
    } else {
        active_row = -7; // Wrap back to top info section
    }
}
if (keyboard_check_pressed(vk_up) || gamepad_button_check_pressed(0, gp_padu)) {
    if (active_row > -7) {
        active_row--;
    } else {
        active_row = array_length(grid_data) - 1; // Wrap to bottom of roster
    }
}
if (keyboard_check_pressed(vk_left) || gamepad_button_check_pressed(0, gp_padl)) {
    if (active_row <= -1 && active_col == 0) {
        active_col = -1; // Highlight portrait selection
    } else if (active_col > 0) {
        active_col--;
    }
}
if (keyboard_check_pressed(vk_right) || gamepad_button_check_pressed(0, gp_padr)) {
    if (active_col == -1) {
        active_col = 0; // Return focus from portrait to fields
    } else {
        active_col = min(active_col + 1, 5);
    }
}

// --- Field Editing ---
if ((keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(0, gp_face1)) && !global.ui_overlay_active) {
    if (active_col == -1) {
        // Portrait Selected — Show Coming Soon
        if (!instance_exists(objComingSoonPopup)) {
            instance_create_layer(display_get_gui_width()/2, display_get_gui_height()/2, "GUI", objComingSoonPopup);
            global.ui_overlay_active = true;
        }
    } else if (active_row < 0) {
        // Editing Team Info (Name/City/Abbr)
        var kb = instance_create_layer(0, 0, "GUI", objVirtualKeyboard);
        kb.target_row = active_row;
        kb.target_col = active_col;
        var info_index = -1 - active_row;
        switch (info_index) {
            case 0: kb.current_string = team_name; break;
            case 1: kb.current_string = team_city; break;
            case 2: kb.current_string = team_abbr; break;
        }
        kb.save_pending = false;
        global.ui_overlay_active = true;
    } else {
        // Editing Player Grid Data
        var kb = instance_create_layer(0, 0, "GUI", objVirtualKeyboard);
        kb.target_row = active_row;
        kb.target_col = active_col;
        kb.current_string = grid_data[active_row].fields[active_col];
        kb.save_pending = false;
        global.ui_overlay_active = true;
    }
}

// --- Save Confirmation Popup ---
if (keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_face2)) {
    if (!instance_exists(objExitConfirm)) {
        instance_create_layer(0, 0, "GUI", objExitConfirm);
        global.ui_overlay_active = true;
    }
}

// --- Scrolling Logic ---
var grid_visible_rows = floor((display_get_gui_height() - grid_offset_y - 280) / row_height);
scroll_y = max(0, active_row * row_height - (grid_visible_rows div 2) * row_height);

// --- Handle Virtual Keyboard Save ---
var kb = instance_find(objVirtualKeyboard, 0);
if (instance_exists(kb) && variable_instance_exists(kb, "save_pending")) {
    if (kb.save_pending) {
        if (kb.target_row < 0) {
            // Update Team Info
            var info_index = -1 - kb.target_row;
            switch (info_index) {
                case 0: team_name = kb.current_string; break;
                case 1: team_city = kb.current_string; break;
                case 2: team_abbr = kb.current_string; break;
            }
        } else {
            // Update Player Grid Data
            grid_data[kb.target_row].fields[kb.target_col] = kb.current_string;
        }
        kb.save_pending = false;
    }
}

// Keep active row position visually locked
scroll_y = max(0, active_row * row_height - (grid_visible_rows div 2) * row_height);
