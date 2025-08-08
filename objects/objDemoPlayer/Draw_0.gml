var sc = 5;

shader_set(shdPaletteTex);

// Bind palette surface to shader if it exists
if (surface_exists(global.pal_surf)) {
    var u_palette = shader_get_uniform(shdPaletteTex, "u_palette");
    texture_set_stage(1, surface_get_texture(global.pal_surf));
    shader_set_uniform_i(u_palette, 1);
}

draw_sprite_ext(sprite_index, image_index, x, y, sc, sc, 0, c_white, 1);

shader_reset();

