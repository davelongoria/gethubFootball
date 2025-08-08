/// rmBoot → Create Event
scr_team_load_all();   // use the save-area loader
scr_seed_teams(); // Ensure TEMPLATE team is initialized at startup

// Ensure lists/maps
if (!variable_global_exists("logo_sprites")) global.logo_sprites = ds_list_create();
if (!variable_global_exists("roster_list")) global.roster_list   = ds_list_create();

// Create mod folders under save area
var base_dir = game_save_id;
var folders  = ["logos", "teams", "rosters", "extras"];
for (var i = 0; i < array_length(folders); ++i) {
    var f = folders[i];
    if (!directory_exists(base_dir + f)) directory_create(base_dir + f);
}

// Palette init + surfaces
scr_palette_init("Default");
if (!surface_exists(global.pal_surf_away)) global.pal_surf_away = surface_create(1,1);
if (!surface_exists(global.pal_surf))      global.pal_surf      = surface_create(1,1);

// Optional custom-logo loader
// scr_load_custom_logos();
