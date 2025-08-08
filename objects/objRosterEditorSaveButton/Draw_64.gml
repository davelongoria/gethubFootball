/// objRosterEditorSaveButton – Draw GUI Event

var btn_x = x;
var btn_y = y;
var btn_w = 220;
var btn_h = 60;

draw_set_font(fntRosterLarge);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (is_selected) {
    draw_set_color(c_yellow);
    draw_rectangle(btn_x, btn_y, btn_x + btn_w, btn_y + btn_h, false);
} else {
    draw_set_color(c_white);
    draw_rectangle(btn_x, btn_y, btn_x + btn_w, btn_y + btn_h, false);
}

draw_text(btn_x + btn_w/2, btn_y + btn_h/2, "SAVE TEAM");
