/// @desc objTeamRosterEditor — Step

// Quick guard against undefined flags (belt & suspenders)
if (!variable_instance_exists(self, "keyboard_finished")) keyboard_finished = false;
if (!variable_instance_exists(self, "keyboard_open"))     keyboard_open     = false;

// Shortcuts
var rows = array_length(grid_data);
if (rows <= 0) exit;

// Do not navigate grid while a keyboard is open
var can_navigate = !keyboard_open;

// ---------------------------
// 1) NAVIGATION (no keyboard)
// ---------------------------
if (can_navigate) {
    // Up/Down (keyboard)
    if (keyboard_check_pressed(vk_up))    selected_row = max(0, selected_row - 1);
    if (keyboard_check_pressed(vk_down))  selected_row = min(rows - 1, selected_row + 1);

    // Page scroll to keep selection on screen
    var visible_rows = floor((display_get_gui_height() - top_margin) / row_height);
    var min_vis = scroll_offset;
    var max_vis = scroll_offset + max(0, visible_rows - 1);
    if (selected_row < min_vis) scroll_offset = selected_row;
    if (selected_row > max_vis) scroll_offset = selected_row - (visible_rows - 1);

    // Left/Right columns only valid for header (3 columns) or players (6)
    var max_cols = (grid_data[selected_row].type == "header") ? 3 : 6;
    if (keyboard_check_pressed(vk_left))  selected_col = clamp(selected_col - 1, 0, max_cols - 1);
    if (keyboard_check_pressed(vk_right)) selected_col = clamp(selected_col + 1, 0, max_cols - 1);

    // Open virtual keyboard: Enter (keyboard) or A (gamepad)
    var a_pressed = (keyboard_check_pressed(vk_enter) ||
                     (gamepad_is_connected(0) && gamepad_button_check_pressed(0, gp_face1)));

    if (a_pressed) {
        // Lock which cell is being edited
        keyboard_target_row = selected_row;
        keyboard_target_col = clamp(selected_col, 0, max_cols - 1);

        // Determine seed text
        var seed = "";
        if (grid_data[selected_row].type == "header") {
            if (keyboard_target_col == 0) seed = team_name;
            if (keyboard_target_col == 1) seed = team_city;
            if (keyboard_target_col == 2) seed = team_abbr;
        } else {
            seed = string(grid_data[selected_row].fields[keyboard_target_col]);
        }

        // Spawn VK
       // Create (or find) a UI layer so the VK sits above game content
var ui_layer_name = "UI_Overlay";
if (layer_get_id(ui_layer_name) == -1) {
    layer_create_depth(-100000, ui_layer_name);
}
var kb = instance_create_layer(0, 0, ui_layer_name, objVirtualKeyboard);

        kb.input_text = seed;
        kb.prompt     = (grid_data[selected_row].type == "header") ? "Edit Team Info" : "Edit Player Field";
        kb.ok_label   = "OK";
        kb.cancel_label = "Cancel";

        keyboard_open      = true;
        keyboard_finished  = false;
        keyboard_cancelled = false;
        is_editing         = true;
    }

    // Exit editor with B/Escape (your confirm popup can hook here later)
    var b_pressed = (keyboard_check_pressed(vk_escape) ||
                     (gamepad_is_connected(0) && gamepad_button_check_pressed(0, gp_face2)));
    if (b_pressed) {
        // Simple clean close for now
        scr_reset_roster_editor_state();
        instance_destroy(); // destroy this editor
        exit;
    }
}

// ------------------------------------------
// 2) VIRTUAL KEYBOARD RESULT (poll + apply)
// ------------------------------------------
if (keyboard_open) {
    var kb_inst = instance_exists(objVirtualKeyboard) ? instance_find(objVirtualKeyboard, 0) : noone;

    if (kb_inst == noone) {
        // Keyboard vanished—reset state so we don't keep waiting
        keyboard_open      = false;
        keyboard_finished  = false;
        keyboard_cancelled = false;
        is_editing         = false;
    } else {
        keyboard_finished  = kb_inst.finished;
        keyboard_cancelled = kb_inst.cancelled;

        if (keyboard_cancelled) {
            // Close VK, keep original value
            with (kb_inst) instance_destroy();
            keyboard_open      = false;
            keyboard_finished  = false;
            keyboard_cancelled = false;
            is_editing         = false;
        }
        else if (keyboard_finished) {
            keyboard_text = kb_inst.output_text;

            // Apply edit
            if (keyboard_target_row >= 0 && keyboard_target_row < rows) {
                var row = grid_data[keyboard_target_row];

                if (row.type == "header") {
                    if (keyboard_target_col == 0) team_name = keyboard_text;
                    if (keyboard_target_col == 1) team_city = keyboard_text;
                    if (keyboard_target_col == 2) team_abbr = keyboard_text;

                    // mirror into header fields so Draw shows new values
                    grid_data[0].fields[0] = team_name;
                    grid_data[0].fields[1] = team_city;
                    grid_data[0].fields[2] = team_abbr;
                }
                else if (row.type == "player") {
                    // write into the visible grid cell
                    row.fields[keyboard_target_col] = keyboard_text;
                    grid_data[keyboard_target_row]  = row;

                    // also push into the backing models immediately
                    scr_roster_apply_grid_to_models("TEMPLATE", grid_data, team_name, team_city, team_abbr);
                }
            }

            // Cleanup VK
            with (kb_inst) instance_destroy();
            keyboard_open      = false;
            keyboard_finished  = false;
            keyboard_cancelled = false;
            is_editing         = false;

            // Mark session dirty if you use a flag
            global.roster_dirty = true;
        }
    }
}
