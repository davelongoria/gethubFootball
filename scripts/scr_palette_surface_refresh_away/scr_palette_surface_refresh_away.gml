/// scr_palette_surface_refresh_away()
///
/// Uses - global.current_pal_away  (array of colours)
///      - global.pal_surf_away     (target surface)

if (variable_global_exists("pal_surf_away") && surface_exists(global.pal_surf_away))
    surface_free(global.pal_surf_away);

// always derive length from the array actually present
var pal_len = array_length(global.current_pal_away);
if (pal_len <= 0) exit;      // nothing to draw

global.pal_surf_away = surface_create(pal_len, 1);
surface_set_target(global.pal_surf_away);
draw_clear_alpha(c_black, 0);

for (var i = 0; i < pal_len; ++i)
{
    draw_set_colour(global.current_pal_away[i]);
    draw_point(i, 0);
}

surface_reset_target();
