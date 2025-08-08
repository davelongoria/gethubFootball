var sc = .5;
shader_set(shdPaletteTex);
draw_sprite_ext(sprite_index, image_index, x, y, sc, sc, 0, c_white, 1);
shader_reset();
