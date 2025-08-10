/// scr_commit_roster_edits_to_template()
///
/// Commits any in-editor edits from the TEMPLATE team back to its file.
/// Should only be called when the roster editor is closing or saving.

if (!variable_global_exists("teams")) {
    show_debug_message("scr_commit_roster_edits_to_template: global.teams not found — aborting.");
    exit;
}

if (!ds_map_exists(global.teams, "TEMPLATE")) {
    show_debug_message("scr_commit_roster_edits_to_template: TEMPLATE team not found — aborting.");
    exit;
}

if (!variable_global_exists("team_name")) {
    show_debug_message("scr_commit_roster_edits_to_template: global.team_name not set — aborting.");
    exit;
}

var tname = global.team_name;
var team  = global.teams[? "TEMPLATE"];

// Make sure the JSON has a stable key:
team.team_name = tname;

// Persist to %LOCALAPPDATA%\teams\<tname>.json
scr_team_save(team);

show_debug_message("scr_commit_roster_edits_to_template: Saved team '" + string(tname) + "'.");
