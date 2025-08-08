/// scr_team_unload_all()
/// Destroys any existing globals before rebuilding.
function scr_team_unload_all() {
    // If the global.teams map exists and is a ds_map, destroy it.
    if (variable_global_exists("teams") && ds_exists(global.teams, ds_type_map)) {
        ds_map_destroy(global.teams);
    }

    // Clear out the variables without using variable_global_unset()
    global.teams = undefined;
    global.team_list = undefined;
}
