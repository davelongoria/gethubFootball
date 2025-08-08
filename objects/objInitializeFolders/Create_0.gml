/// Create Event of objInitializeFolders
alarm[1]=50;
// Base custom data directory path
var dir_base = "data/custom/";

// Check and create the main custom directory
if (!directory_exists(dir_base))        directory_create(dir_base);
if (!directory_exists(dir_base + "logos"))    directory_create(dir_base + "logos");
if (!directory_exists(dir_base + "teams"))    directory_create(dir_base + "teams");
if (!directory_exists(dir_base + "rosters"))  directory_create(dir_base + "rosters");
if (!directory_exists(dir_base + "palettes")) directory_create(dir_base + "palettes");

// You can add more subfolders here as needed later (e.g., "stadiums", "music", etc.)

// Ensure the game's save folders (logos, teams, rosters, extras) exist using script helper
scr_initialize_folders();

// Initialize global structures (rosters, team_control, logo_sprites)
scr_global_init();
