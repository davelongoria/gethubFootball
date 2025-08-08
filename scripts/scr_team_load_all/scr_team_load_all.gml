/// scr_team_load_all()
/// Clears globals, loads every .json in %LOCALAPPDATA%\ForAgentFootball\teams\
function scr_team_load_all()
{
    // Unload old
    if (variable_global_exists("teams") && ds_exists(global.teams, ds_type_map))
        ds_map_destroy(global.teams);
    global.teams     = ds_map_create();
    global.team_list = [];

    // Load new
    var base_dir = game_save_id + "teams/";
    if (!directory_exists(base_dir)) directory_create(base_dir);

    var fn = file_find_first(base_dir + "*.json", 0);
    while (fn != "") {
        scr_team_load(base_dir + fn);
        fn = file_find_next();
    }
    file_find_close();

    // Build list
    var k = ds_map_find_first(global.teams);
    while (k != undefined) { array_push(global.team_list, k); k = ds_map_find_next(global.teams, k); }
    show_debug_message("scr_team_load_all – loaded " + string(array_length(global.team_list)) + " teams");
}
