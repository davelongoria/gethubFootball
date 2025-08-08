/// scr_initialize_folders()
var dirs = [
    game_save_id + "logos/",
    game_save_id + "teams/",
    game_save_id + "rosters/",
    game_save_id + "extras/"
];

for (var i = 0; i < array_length(dirs); ++i) {
    if (!directory_exists(dirs[i])) {
        directory_create(dirs[i]);
        show_debug_message("Created folder: " + dirs[i]);
    } else {
        show_debug_message("Folder exists: " + dirs[i]);
    }
}
