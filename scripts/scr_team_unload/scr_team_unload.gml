/// scr_team_unload()
/// Destroys the global.teams map and clears team_list.
function scr_team_unload() {
    if (variable_global_exists("teams") && ds_exists(global.teams, ds_type_map)) {
        ds_map_destroy(global.teams);
        variable_global_unset("teams");
    }
    if (variable_global_exists("team_list")) {
        variable_global_unset("team_list");
    }
}
