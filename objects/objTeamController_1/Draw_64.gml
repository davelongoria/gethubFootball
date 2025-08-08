/// objTeamController – Draw GUI
//--------------------------------------------------------------
draw_set_font(font1);
draw_set_halign(fa_center);
draw_set_valign(fa_top);

// column labels
draw_set_color(c_yellow);
draw_text(xs[0]+66, y_row -86, "HOME");
draw_set_color(c_lime);
draw_text(xs[1]+66, y_row - 86, "AWAY");

// team names under helmets
draw_set_color(c_white);
draw_text(xs[0]+66, y_row +  70, teams[home_index]);
draw_text(xs[1]+66, y_row +  70, teams[away_index]);

// input hint (simple)
if (!gamepad_is_connected(0))
{
    draw_set_color(c_gray);
    draw_text(display_get_gui_width()/2, display_get_gui_height()-64,
              "← A / D  to swap · W / S  to scroll teams");
}
else
{
    draw_set_color(c_gray);
    draw_text(display_get_gui_width()/2, display_get_gui_height()-64,
              "Left-stick ←→ swap · ↑↓ scroll   |   START on Pad-2 to join");
}

// put this near the end of your Draw-GUI:

var hint_x = display_get_gui_width()  * 0.5;   // centred
var hint_y = display_get_gui_height() - 40;    // just above bottom

draw_set_color(c_gray);
draw_set_halign(fa_center);
draw_set_valign(fa_top);

if (!cpu_pick_mode)
    draw_text(hint_x, hint_y,
        "<L3>  (left-stick click)  —  choose CPU/Away team");
else
    draw_text(hint_x, hint_y,
        "<L3>  —  back to normal  (P1 controls current side)");
