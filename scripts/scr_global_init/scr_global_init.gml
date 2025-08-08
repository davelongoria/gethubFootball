/// scr_global_init()
/// Called during game start to initialize global data and folders.
/// This now ensures that save directories, rosters map, team control map and logo sprite list exist.

// Ensure save folders exist (logos, teams, rosters, extras)
scr_initialize_folders();

// Create global roster map if it doesn't exist or isn't a DS map
if (!variable_global_exists("rosters") || !ds_exists(global.rosters, ds_type_map)) {
    global.rosters = ds_map_create();
}

// Create global team control map if it doesn't exist or isn't a DS map
if (!variable_global_exists("team_control") || !ds_exists(global.team_control, ds_type_map)) {
    global.team_control = ds_map_create();
}

// Create logo_sprites list if it doesn't exist
if (!variable_global_exists("logo_sprites")) {
    global.logo_sprites = ds_list_create();
}
