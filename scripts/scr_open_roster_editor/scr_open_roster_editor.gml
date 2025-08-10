/// scr_open_roster_editor(roster_array)
// Copies roster into session AND spawns the editor on a UI layer
function scr_open_roster_editor(roster_array) {
    // 1) copy session data
    global.roster_editor_data = array_create(array_length(roster_array), 0);
    array_copy(global.roster_editor_data, 0, roster_array, 0, array_length(roster_array));

    // 2) ensure UI layer exists (deep depth so GUI stuff is “on top”)
    var ui_layer_name = "UI_Overlay";
    if (layer_get_id(ui_layer_name) == -1) {
        layer_create_depth(-100000, ui_layer_name);
    }

    // 3) spawn DIMMER FIRST (so its Draw GUI happens before the editor)
    if (!instance_exists(objModalDimmer)) {
        var dim = instance_create_layer(0, 0, ui_layer_name, objModalDimmer);
        dim.depth = -10000;   // dimmer below editor GUI
    }

    // 4) spawn the editor (after the dimmer)
    if (!instance_exists(objTeamRosterEditor)) {
        var ed = instance_create_layer(0, 0, ui_layer_name, objTeamRosterEditor);
        ed.depth = -1000000;  // ensure it draws after the dimmer (if any non‑GUI slips in)
    }

    // 5) flag
    global.roster_editor_active = true;
}
