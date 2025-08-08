draw_set_font(font2);

for (var i = 0; i < 3; i++) {
    var field_ypos = y + offset_y[i];
    var field_xpos = x + box_x;
    var field_value = "";
    switch (i) {
        case 0: field_value = team_name; break;
        case 1: field_value = team_city; break;
        case 2: field_value = team_abbr; break;
    }
    draw_set_color(c_white);
    draw_text(field_xpos, field_ypos - 20, field_labels[i]);
    draw_set_color(i == active_field ? c_grey : c_dkgray);
    draw_rectangle(field_xpos, field_ypos, field_xpos+box_w, field_ypos+box_h, false);
    draw_set_color(c_white);
    draw_text(field_xpos + 12, field_ypos + 8, field_value);

    if (i == active_field && (current_time div 400) mod 2 == 0) {
        draw_text(field_xpos + 12 + string_width(field_value), field_ypos + 8, "|");
    }
}
