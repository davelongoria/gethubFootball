
if (variable_global_exists("pal_surf") && surface_exists(global.pal_surf))
    surface_free(global.pal_surf);

var pal_len = array_length(global.current_pal); // SAFEST!

global.pal_surf = surface_create(pal_len, 1);
surface_set_target(global.pal_surf);
draw_clear_alpha(c_black, 0);

for (var i = 0; i < pal_len; ++i) {
    draw_set_colour(global.current_pal[i]);
    draw_point(i, 0);
}

surface_reset_target();



