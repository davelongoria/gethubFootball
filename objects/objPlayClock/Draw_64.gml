/// @description Insert description here
// You can write your code in this editor
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_font(-1);
draw_set_color(c_white);

// Draw play clock
var time_left = max(0, floor(objQB.play_clock / room_speed));
draw_text(view_xview[0] + view_wview[0] / 2, view_yview[0] + 10, "Clock: " + string(time_left));

// Draw home score (top-left)
draw_text(view_xview[0] + 40, view_yview[0] + 10, "HOME: " + string(global.score_home));
