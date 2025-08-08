var over = point_in_rectangle(mouse_x, mouse_y, x, y, x + 32, y + 32);

{
    var oldc = surface_getpixel(global.pal_surf, palette_index, 0);
    var newc = get_color(oldc);
    if (newc != -1)
    {
        // write 1-pixel in palette surface
        surface_set_target(global.pal_surf);
        draw_set_colour(newc);
        draw_point(palette_index, 0);
        surface_reset_target();

        global.current_pal[palette_index] = newc;  // keep array in sync
        // (no flag needed because controller binds every frame)
    }
}
