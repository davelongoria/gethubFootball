// Color scheme (dark style)
var color_bg          = make_color_rgb(34, 34, 34);
var color_btn_idle    = make_color_rgb(40, 40, 40);
var color_btn_hover   = c_white  //make_color_rgb(80, 140, 250);
var color_btn_selected= c_white//make_color_rgb(50, 220, 70);
var color_text        = c_white;
var color_text_shadow = make_color_rgb(20, 20, 20);
var color_arrow       = make_color_rgb(220,220,40);

var btn_x      = display_get_gui_width()/2 - 120;
var btn_y_base = 180;
var btn_w      = 240;
var btn_h      = 55;
var btn_gap    = 18;

var menu_len = array_length(menu_buttons);

draw_set_font(font1);

draw_set_alpha(0.85 * fade);
draw_set_color(color_bg);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1);

// Draw title
draw_set_color(color_text);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_alpha(fade);
draw_text(display_get_gui_width()/2, 50, "PAUSED");

// Draw all menu buttons
for (var i = 0; i < menu_len; ++i) {
    var this_btn_y = btn_y_base + i * (btn_h + btn_gap);
    var btn_col = color_btn_idle;
    if (selected == i) btn_col = color_btn_selected;
    else if (hovered == i) btn_col = color_btn_hover;

    draw_set_alpha(fade);
    draw_set_color(btn_col);
    draw_roundrect(btn_x, this_btn_y, btn_x+btn_w, this_btn_y+btn_h, false);

    draw_set_color(color_text_shadow);
    draw_text(btn_x + btn_w/2 + 2, this_btn_y + btn_h/4 + 2, menu_buttons[i]);
    draw_set_color(color_text);
    draw_text(btn_x + btn_w/2, this_btn_y + btn_h/4, menu_buttons[i]);
}
draw_set_alpha(1);
