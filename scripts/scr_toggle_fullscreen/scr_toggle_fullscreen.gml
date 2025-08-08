/// scr_toggle_fullscreen()

// Toggle fullscreen
var new_state = !window_get_fullscreen();
window_set_fullscreen(new_state);

// Set a flag to refresh the palette surface in the controller
global.palette_needs_refresh = true;
