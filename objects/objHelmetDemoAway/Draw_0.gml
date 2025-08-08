var sc = 0.5;

shader_set(shdPaletteTex);

// bind **AWAY** palette surface to texture stage 1
if (surface_exists(global.pal_surf_away))
{
    texture_set_stage(1, surface_get_texture(global.pal_surf_away));
    var u_pal = shader_get_uniform(shdPaletteTex, "u_palette");
    shader_set_uniform_i(u_pal, 1);
}

draw_sprite_ext(sprite_index, image_index, x, y, sc, sc, 0, c_white, 1);
shader_reset();
