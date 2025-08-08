/// objExitConfirm - Draw GUI Event

var w = display_get_gui_width();
var h = display_get_gui_height();
var cx = w / 2;
var cy = h / 2;

// Dim Full Screen

if (!variable_global_exists("exit_confirm_active")) global.exit_confirm_active = true;
draw_set_color(c_black);
draw_set_alpha(0.8);
draw_rectangle(0, 0, w, h, false);
draw_set_alpha(1);

// Question Text
draw_set_font(fntRosterLarge);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(cx, cy - 40, question_text);

// Options Text
var yes_color = (selected_option == 0) ? c_yellow : c_white;
var no_color = (selected_option == 1) ? c_yellow : c_white;
draw_set_color(yes_color);
draw_text(cx - 80, cy + 30, "Yes");
draw_set_color(no_color);
draw_text(cx + 80, cy + 30, "No");
