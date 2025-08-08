/// Draw GUI Event

draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_font(font1); // Optional custom font
draw_set_color(c_white);
/*
// Show play clock centered at top of view
var time_left = max(0, floor(play_clock / room_speed));

draw_text(view_xview[0] + view_wview[0] / 2, view_yview[0] + 10, string(time_left));
