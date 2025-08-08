/// scr_team_save(team)
/// Saves a team struct as JSON into %LOCALAPPDATA%\ForAgentFootball\teams\
function scr_team_save(team)
{
    if (!is_struct(team) || !variable_struct_exists(team, "team_name")) return false;
    var name     = string(team.team_name);
    var base_dir = game_save_id + "teams/";
    if (!directory_exists(base_dir)) directory_create(base_dir);

    // Copy colours as decimal integers (hex -> real)
    if (variable_struct_exists(team, "colours")) {
        var col_dec = array_create(array_length(team.colours), 0);
        for (var i = 0; i < array_length(team.colours); ++i) {
            col_dec[i] = team.colours[i] & 0xFFFFFF; // strip to 24-bit int
        }
        team.colours = col_dec;
    }

    // Write JSON
    string_save(base_dir + name + ".json", json_stringify(team, true));
    show_debug_message("scr_team_save – saved \"" + name + "\" to " + base_dir);

    // Reload list
    scr_team_load_all();
    return true;
}

/// ----------------------------------------------------------
/// Additional utility functions for rosters and team control.

/// scr_roster_save(team_name, roster)
/// Save a roster array or struct to the rosters folder. The file will be named <team_name>_roster.json.
function scr_roster_save(team_name, roster) {
    if (team_name == "" || roster == undefined) return false;
    var base_dir = game_save_id + "rosters/";
    if (!directory_exists(base_dir)) {
        directory_create(base_dir);
    }
    var fname = base_dir + string(team_name) + "_roster.json";
    string_save(fname, json_encode(roster, true));
    show_debug_message("scr_roster_save – Saved roster for " + team_name);
    return true;
}

/// scr_roster_load(team_name)
/// Load a roster for the given team name from the rosters folder. Returns the parsed JSON struct or undefined if not found.
function scr_roster_load(team_name) {
    var base_dir = game_save_id + "rosters/";
    var fname = base_dir + string(team_name) + "_roster.json";
    if (file_exists(fname)) {
        var fh  = file_text_open_read(fname);
        var raw = file_text_read_string(fh);
        file_text_close(fh);
        return json_parse(raw);
    }
    return undefined;
}

/// scr_assign_team_control(team_name, controller)
/// Assigns a team to a controller: 0 = CPU, 1 = player one, 2 = player two.
function scr_assign_team_control(team_name, controller) {
    // ensure the team_control map exists
    if (!variable_global_exists("team_control") || !ds_exists(global.team_control, ds_type_map)) {
        global.team_control = ds_map_create();
    }
    ds_map_replace(global.team_control, team_name, controller);
}

/// scr_get_team_control(team_name)
/// Retrieves the controller assignment for a team. Returns 0 if none exists.
function scr_get_team_control(team_name) {
    // return the controller assignment if the map exists
    if (variable_global_exists("team_control") && ds_exists(global.team_control, ds_type_map)) {
        if (ds_map_exists(global.team_control, team_name)) {
            return global.team_control[? team_name];
        }
    }
    return 0;
}
