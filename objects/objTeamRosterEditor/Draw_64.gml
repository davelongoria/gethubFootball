/// objTeamRosterEditor - Draw GUI Event

// Skip Drawing if UI Overlay is Active
if (global.ui_overlay_active) exit;

var start_y = grid_offset_y;
var col_offset = scroll_col;

// Draw Player Portrait (Top Left)
draw_set_font(fntRosterLarge);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_sprite(sprPlayerPortrait, 0, 40, 40);

// Draw Yellow Outline if Portrait is Selected
if (active_col == -1) {
    var spr_w = sprite_get_width(sprPlayerPortrait);
    var spr_h = sprite_get_height(sprPlayerPortrait);
    draw_set_color(c_yellow);
    draw_line(40 - 2, 40 - 2, 40 + spr_w + 2, 40 - 2);
    draw_line(40 - 2, 40 + spr_h + 2, 40 + spr_w + 2, 40 + spr_h + 2);
    draw_line(40 - 2, 40 - 2, 40 - 2, 40 + spr_h + 2);
    draw_line(40 + spr_w + 2, 40 - 2, 40 + spr_w + 2, 40 + spr_h + 2);
}

// Draw Player Info Section to the Right of Portrait
var info_x_start = 40 + sprite_get_width(sprPlayerPortrait) + 400;
var info_y = 40;
var info_labels = ["TEAM NAME:", "CITY:", "ABBR:", "College:", "Yrs Pro:", "Ht/Wt:", "Age:"];
var info_values = [team_name, team_city, team_abbr, "N/A", "N/A", "N/A", "N/A"];

for (var i = 0; i < array_length(info_labels); i++) {
    var is_active_field = (active_row == -1 - i && active_col != -1);
    draw_set_color(is_active_field ? c_yellow : c_white);
    draw_text(info_x_start, info_y + i * 40, info_labels[i] + " " + info_values[i]);
}

// Adjust Static Field Labels Position
var field_label_y = grid_offset_y + 200;
var labels = ["POS", "SPD", "STR", "AGI", "POW", "DUR"];
for (var col = 0; col < array_length(labels); col++) {
    draw_set_color(c_white);
    draw_text(col_positions[col], field_label_y, labels[col]);
}

var grid_visible_rows = floor((display_get_gui_height() - field_label_y - 80) / row_height);
var base_row = clamp(active_row, 0, array_length(grid_data) - 1);

// Adjust scrolling so active_row stays centered
var visual_row_y = field_label_y + row_height * (grid_visible_rows div 2);
var scroll_offset = (base_row * row_height) - (visual_row_y - (field_label_y + row_height));

var row_y = field_label_y + row_height;

for (var i = 0; i < array_length(grid_data); i++) {
    var y_pos = row_y - scroll_offset;
    if (y_pos < field_label_y + row_height || y_pos > display_get_gui_height() - 40) {
        row_y += row_height;
        continue;
    }

    var is_active_row = (i == active_row);
    var row = grid_data[i];

    if (i == 0 && row.type == "info") {
        for (var col = 0; col < 3; col++) {
            var is_active_field = is_active_row && (col == active_col);
            draw_set_color(is_active_field ? c_yellow : c_white);
            draw_text(col_positions[col], y_pos, row.fields[col]);
        }
        row_y += row_height;
        continue;
    }

    if (row.type == "player") {
        var scale_factor = (is_dragging && is_active_row) ? 1.1 : 1;

        for (var col = 0; col < 6; col++) {
            var actual_col = col + col_offset;
            if (actual_col >= array_length(row.fields)) break;
            var is_active_field = is_active_row && (col == active_col);
            draw_set_color(is_active_field ? c_yellow : c_white);
            draw_text_transformed(col_positions[col], y_pos, row.fields[actual_col], scale_factor, scale_factor, 0);
        }
    }
    row_y += row_height;
}

// Draw Instructions
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_text(display_get_gui_width()/2, display_get_gui_height() - 40, "D-Pad/Stick: Move  | A: Edit/Drag  | Start: Save  | B: Backspace");
