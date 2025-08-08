// Draw GUI event
if (variable_global_exists("color_swatch_labels")) {
    var oldfont = draw_get_font();
    var oldcol = draw_get_color();
    draw_set_font(font0); // replace font0 with your font, or set a specific font with size 16
    draw_set_color(c_white);
    for (var i = 0; i < array_length(global.color_swatch_labels); ++i) {
        var label = global.color_swatch_labels[i];
        draw_set_color(c_white);
        draw_text(label.x, label.y, string_upper(label.text)); // Bold effect via uppercase
    }
    draw_set_font(oldfont);
    draw_set_color(oldcol);
}
