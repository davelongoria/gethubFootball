/// scr_save_team_data

// Commit edits from roster_editor_data back to TEMPLATE

if (variable_global_exists("teams") && ds_map_exists(global.teams, "TEMPLATE")) {
    var current_team = global.teams[? "TEMPLATE"];

    // Save Team Info
    current_team.team_name = team_name;
    current_team.city = team_city;
    current_team.team_abbr = team_abbr;

    // Deep Copy Roster Data
    var new_roster = array_create(array_length(global.roster_editor_data), 0);
    for (var i = 0; i < array_length(global.roster_editor_data); i++) {
        new_roster[i] = global.roster_editor_data[i];
    }

    current_team.roster = new_roster;

    // Debug Output: After Save
    show_debug_message("=== TEMPLATE ROSTER AFTER SAVE ===");
    for (var i = 0; i < array_length(current_team.roster); i++) {
        var player = current_team.roster[i];
        show_debug_message("[" + string(i) + "] " + player.name);
    }

    show_debug_message("[SAVE] Team Data Committed to TEMPLATE.");
} else {
    show_debug_message("ERROR: Could not save team data - TEMPLATE not found.");
}
