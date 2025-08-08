if (variable_global_exists("color_swatch_labels")) {
    draw_set_color(c_white);
    draw_set_font(-1); // Replace with your desired font
    for (var i = 0; i < array_length(global.color_swatch_labels); ++i) {
        var label = global.color_swatch_labels[i];
        draw_text(label.x, label.y, string_upper(label.text));
    }
}
