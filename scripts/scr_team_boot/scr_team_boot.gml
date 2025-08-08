function scr_team_boot() {
    // Clear current teams
    if (variable_global_exists("teams") && ds_exists(global.teams, ds_type_map)) {
        ds_map_destroy(global.teams);
    }
    global.teams = ds_map_create();
    // Find JSON files in the save-area teams folder
    var base_dir = game_save_id + "teams/";
    if (!directory_exists(base_dir)) directory_create(base_dir);
    var pattern = base_dir + "*.json";
    var fname   = file_find_first(pattern, 0);
    while (fname != "") {
        scr_team_load(base_dir + fname);
        fname = file_find_next();
    }
    file_find_close();
    // Build the team list for menus
    global.team_list = [];
    var key = ds_map_find_first(global.teams);
    while (key != undefined) {
        array_push(global.team_list, key);
        key = ds_map_find_next(global.teams, key);
    }
}
