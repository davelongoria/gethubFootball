var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

if (point_in_rectangle(mx, my, 600, 540, 760, 580)) {
    scr_show_roster_editor(team.roster);
}
