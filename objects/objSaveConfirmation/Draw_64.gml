/// objSaveConfirmation - Create Event

lifetime = 90;    // Duration in steps (1.5 seconds at 60fps)
alpha = 1;


/// objSaveConfirmation - Step Event

lifetime--;

if (lifetime < 30) {
    alpha = lifetime / 30;  // Fade out smoothly
}

if (lifetime <= 0) {
    instance_destroy();
}


/// objSaveConfirmation - Draw GUI Event

draw_set_alpha(alpha);
draw_set_font(fntRosterLarge);
draw_set_color(c_white);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var cx = display_get_gui_width() / 2;
var cy = display_get_gui_height() / 2;

draw_text(cx, cy, "Team Saved!");

draw_set_alpha(1);
