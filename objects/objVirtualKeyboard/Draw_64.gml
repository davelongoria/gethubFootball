/// @desc objVirtualKeyboard — Draw GUI

var GW = display_get_gui_width();
var GH = display_get_gui_height();

// Modal backdrop
draw_set_alpha(0.85);
draw_set_color(c_black);
draw_rectangle(0, 0, GW, GH, false);
draw_set_alpha(1);

// Panel
var panel_w = 560;
var panel_h = 300;
var panel_x = (GW - panel_w) * 0.5;
var panel_y = (GH - panel_h) * 0.5;

draw_set_color(c_white);
draw_rectangle(panel_x, panel_y, panel_x + panel_w, panel_y + panel_h, true);
draw_set_color(c_black);
draw_rectangle(panel_x, panel_y, panel_x + panel_w, panel_y + panel_h, false);

// Prompt
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(panel_x + 16, panel_y + 12, string(prompt));

// Current text (with blinking caret)
var caret_on = (floor(current_time / 300) mod 2) == 0;
var shown = input_text + (caret_on ? "|" : "");
draw_text(panel_x + 16, panel_y + 44, shown);

// On‑screen keyboard grid
var gx = panel_x + 16;
var gy = panel_y + 90;

for (var r = 0; r < grid_rows; r++) {
    for (var c = 0; c < grid_cols; c++) {
        var idx = r * grid_cols + c;
        if (idx >= array_length(keys)) continue;

        var kx = gx + c * (cell_w + 8);
        var ky = gy + r * (cell_h + 8);

        // Highlight
        if (r == cursor_row && c == cursor_col) {
            draw_set_color(c_yellow);
            draw_rectangle(kx - 2, ky - 2, kx + cell_w + 2, ky + cell_h + 2, true);
            draw_set_color(c_black);
            draw_text(kx + 8, ky + 8, string(keys[idx]));
            draw_set_color(c_black);
            draw_rectangle(kx - 2, ky - 2, kx + cell_w + 2, ky + cell_h + 2, false);
        } else {
            draw_set_color(make_color_rgb(230,230,230));
            draw_rectangle(kx, ky, kx + cell_w, ky + cell_h, true);
            draw_set_color(c_black);
            draw_rectangle(kx, ky, kx + cell_w, ky + cell_h, false);
            draw_text(kx + 8, ky + 8, string(keys[idx]));
        }
    }
}

// Footer
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_black);
draw_text(panel_x + panel_w * 0.5, panel_y + panel_h - 26,
          "OK = Enter/Start • Backspace = ← key or Backspace • Cancel = Esc/B");
