/// objPortraitEditor.DrawGUI

// Fullscreen dim behind editor
draw_set_alpha(0.55);
draw_set_color(c_black);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1);

// Panel
draw_set_color(make_color_rgb(12,12,12));
draw_rectangle(panel_x, panel_y, panel_x+panel_w, panel_y+panel_h, false);
draw_set_color(c_white);
draw_rectangle(panel_x, panel_y, panel_x+panel_w, panel_y+panel_h, true);

// Title
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(fntRosterLarge);
draw_text(panel_x + 20, panel_y + 16, "Player Portrait Editor");

// Live preview
scr_draw_player_portrait(edit_portrait, portrait_x, portrait_y, portrait_scale);

// Category list
var list_x = panel_x + 24;
var list_y = panel_y + 70;
for (var i = 0; i < array_length(categories); i++) {
    var sel = (i == cat_index);
    draw_set_color(sel ? c_yellow : c_white);
    draw_text(list_x, list_y + i*36, categories[i].name);
}

// Mode + help
var c = categories[cat_index];
var mode_name = (mode == 0) ? "STYLE" : "COLOR";
draw_set_color(c_white);
draw_text(panel_x + 20, panel_y + panel_h - 110, "Mode: " + mode_name);

var help  = "Up/Down: Category  |  Left/Right: Change ";
help += (mode==0) ? "Style" : "Color";
help += "  |  X: Toggle Style/Color  |  Start/A: Save  |  Y/Esc: Cancel  |  B: Close (no save)";
draw_text(panel_x + 20, panel_y + panel_h - 70, help);

// Value readout
var ky = c.key;
var ref = variable_struct_get(edit_portrait, ky);
var val_text = "Frame: " + string(ref.frame);
if (c.has_color) val_text += "    Color: " + string(ref.color);
draw_text(panel_x + 20, panel_y + panel_h - 150, categories[cat_index].name + " — " + val_text);
