// Rebuild the palette surface if it was wiped out (e.g., fullscreen switch)
if (!surface_exists(global.pal_surf)) {
    scr_palette_surface_refresh();
}
