/// @description Insert description here
// You can write your code in this editor
if (global.palette_needs_refresh) {
    if (!surface_exists(global.pal_surf)) {
        scr_palette_surface_refresh();
    }
    global.palette_needs_refresh = false;
}
