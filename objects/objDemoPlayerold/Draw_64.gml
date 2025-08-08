// --- Sprite bounds in GUI coords ---
var preview_x = x; // or GUI x
var preview_y = y+150; // or GUI y

var frame_w = sprite_get_width(sprite_index);
var frame_h = sprite_get_height(sprite_index);

var button_w = frame_w;
var button_h = 28;
var button_x = preview_x;
var button_y = preview_y + frame_h + button_y_offset;

// --- Draw button ---
draw_set_color(c_dkgray);
draw_rectangle(button_x, button_y, button_x + button_w, button_y + button_h, false);

// --- Draw button text ---
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
var btn_text = animation_paused ? "PLAY" : "PAUSE";
draw_text(button_x + button_w / 2, button_y + button_h / 2, btn_text);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// --- Click detection (mouse in button area) ---
if (mouse_check_button_pressed(mb_left)) {
    var mx = device_mouse_x_to_gui(0); // convert to GUI space if needed
    var my = device_mouse_y_to_gui(0);
    if (mx >= button_x && mx <= button_x + button_w && my >= button_y && my <= button_y + button_h) {
        animation_paused = !animation_paused; // Toggle pause/play!
    }
}
