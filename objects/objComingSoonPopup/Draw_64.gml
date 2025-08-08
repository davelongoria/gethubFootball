/// objComingSoonPopup - Draw GUI Event

var w = display_get_gui_width();
var h = display_get_gui_height();
var cx = w / 2;
var cy = h / 2;

// Dim Full Screen
if (!variable_global_exists("coming_soon_active")) global.coming_soon_active = false;
draw_set_color(c_black);
draw_set_alpha(0.8);
draw_rectangle(0, 0, w, h, false);
draw_set_alpha(1);
/*
// Popup Box Fill (Black)
draw_set_color(c_black);
draw_rectangle(cx - 220, cy - 100, cx + 220, cy + 100, true);

// Popup Box Outline (White)
draw_set_color(c_white);
draw_rectangle(cx - 220, cy - 100, cx + 220, cy + 100, false);
*/
// Text
draw_set_font(fntRosterLarge);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(cx, cy, "Coming Soon!");
