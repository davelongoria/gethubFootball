/// objRosterEditorSaveButton – Mouse Left Pressed Event

if (audio_exists(sndPressed)) audio_play_sound(sndPressed, 0, false);

// Ensure global.team_info exists
if (!variable_global_exists("team_info")) {
    global.team_info = ds_map_create();
}

// Determine current team being edited
var teamname = (variable_global_exists("team_to_edit")) ? global.team_to_edit : "TEMPLATE";

// Save Team Info Fields
var info_arr = [global.team_name, global.team_city, global.team_abbr, global.logo_frame];
global.team_info[? teamname] = info_arr;

// Save Roster Data back to global.teams
if (variable_global_exists("teams") && ds_map_exists(global.teams, teamname)) {
    var team_struct = global.teams[? teamname];
    if (is_struct(team_struct)) {
        team_struct.roster = array_create(array_length(global.roster_editor_data), 0);
        array_copy(team_struct.roster, 0, global.roster_editor_data, 0, array_length(global.roster_editor_data));
    }
}

// Save Palette back to team_palettes
if (variable_global_exists("team_palettes") && ds_map_exists(global.team_palettes, teamname)) {
    var pal_copy = array_create(array_length(global.current_pal), 0);
    array_copy(pal_copy, 0, global.current_pal, 0, array_length(global.current_pal));
    global.team_palettes[? teamname] = pal_copy;
}

// OPTIONAL: Save to file (e.g., scr_team_save(team_struct));

// Show Save Confirmation Popup
instance_create_layer(0, 0, "GUI", objSaveConfirmation);

// Close the Editor Overlay
global.roster_editor_active = false;
if (instance_exists(objModalDimmer)) with (objModalDimmer) instance_destroy();
with (objTeamRosterEditor) instance_destroy();
