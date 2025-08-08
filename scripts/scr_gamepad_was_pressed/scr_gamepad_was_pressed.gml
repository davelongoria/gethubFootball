/// scr_gamepad_was_pressed(btn, pad)
/// Safe wrapper around gamepad_button_check_pressed
///
/// btn : (constant)  gp_padl / gp_face1 / gp_start …
/// pad : game-pad index 0-7  (defaults to 0)

var _btn = argument_count > 0 ? argument0 : -1;
var _pad = argument_count > 1 ? argument1 : 0;

// If the button id is not a real number → just return false
if (!is_real(_btn) || _btn < 0) return false;

// If pad isn’t connected → false
if (!gamepad_is_connected(_pad)) return false;

return gamepad_button_check_pressed(_pad, _btn);
