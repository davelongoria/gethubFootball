if (visible) {
    draw_sprite(sprite_index, image_index, x, y + visual_z);
}

if (global.play_active && attached_to == noone) {
    draw_set_color(c_red);
    draw_circle(target_x, target_y, 6, false);
}
