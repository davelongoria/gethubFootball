// Drawing current logo (supports built-in and custom)
if (frame < num_builtins) {
    // Built-in logo (all frames of builtin_sprite)
    draw_sprite(builtin_sprite, frame, x, y);
} else {
    var custom_idx = frame - num_builtins;
    if (is_array(global.custom_logos) && custom_idx >= 0 && custom_idx < array_length(global.custom_logos)) {
        draw_sprite(global.custom_logos[custom_idx], 0, x, y);
    }
}
