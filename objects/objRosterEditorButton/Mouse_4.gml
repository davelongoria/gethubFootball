/// objRosterEditorButton – Mouse Left Pressed Event

if (!variable_global_exists("roster_editor_active")) {
    global.roster_editor_active = false;
}

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

if (point_in_rectangle(mx, my, x, y, x + button_width, y + button_height)) {
    if (audio_exists(sndPressed)) audio_play_sound(sndPressed, 0, false); // Play press sound

    if (!global.roster_editor_active) {
        if (variable_global_exists("teams") && ds_map_exists(global.teams, "TEMPLATE")) {
            var current_team = global.teams[? "TEMPLATE"];

            if (is_struct(current_team) && variable_struct_exists(current_team, "roster")) {
                // Copy TEMPLATE roster into editable buffer
                global.roster_editor_data = array_create(array_length(current_team.roster), 0);
                array_copy(global.roster_editor_data, 0, current_team.roster, 0, array_length(current_team.roster));

                // Activate Roster Editor Mode
                global.roster_editor_active = true;

                // 🛡️ Spawn Dimmer first to block UI behind
                if (!instance_exists(objModalDimmer)) {
                    instance_create_layer(0, 0, "GUI", objModalDimmer);
                }

                // 🔥 Spawn the new Unified Team + Roster Editor
                instance_create_layer(0, 0, "GUI", objTeamRosterEditor);

            } else {
                show_debug_message("ERROR: TEMPLATE team or roster not found.");
            }
        } else {
            show_debug_message("ERROR: global.teams not found or TEMPLATE entry missing.");
        }
    }
}
