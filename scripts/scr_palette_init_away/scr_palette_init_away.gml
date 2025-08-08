/// scr_palette_init_away(team_name)
//
//  • Reads from the same global.team_palettes map you already have
//  • Writes to _away globals so it never interferes with the “home” values
//  • Finishes by rebuilding the away palette surface
/// scr_palette_init_away(team_name)

// ------------------------------------------------------------
// Ensure the palette map exists. If not, build it via the
// original home script (once) with the default palette.
// ------------------------------------------------------------
if (!variable_global_exists("team_palettes"))
{
    // NOTE: scr_palette_init() will create the map & default palette
    scr_palette_init("Default");
}

var team_name = argument0;

// ---------- pull palette ----------
if (ds_map_exists(global.team_palettes, team_name))
{
    global.current_pal_away  = global.team_palettes[? team_name];
    global.current_team_away = team_name;
}
else
{
    global.current_pal_away  = global.team_palettes[? "Default"];
    global.current_team_away = "Default";
}

global.palette_size_away = array_length(global.current_pal_away);

// ---------- build / refresh surface ----------
scr_palette_surface_refresh_away();
