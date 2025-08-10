/// @desc objVirtualKeyboard — Step

// Move cursor
var moved = false;
if (keyboard_check_pressed(vk_left) || (gamepad_is_connected(0) && gamepad_button_check_pressed(0, gp_padl))) { cursor_col = max(0, cursor_col - 1); moved = true; }
if (keyboard_check_pressed(vk_right)|| (gamepad_is_connected(0) && gamepad_button_check_pressed(0, gp_padr))) { cursor_col = min(grid_cols - 1, cursor_col + 1); moved = true; }
if (keyboard_check_pressed(vk_up)   || (gamepad_is_connected(0) && gamepad_button_check_pressed(0, gp_padu))) { cursor_row = max(0, cursor_row - 1); moved = true; }
if (keyboard_check_pressed(vk_down) || (gamepad_is_connected(0) && gamepad_button_check_pressed(0, gp_padd))) { cursor_row = min(grid_rows - 1, cursor_row + 1); moved = true; }

if (moved) blink_timer = 0;
blink_timer++;

// Select key with Enter or A
var select_pressed = keyboard_check_pressed(vk_enter) || (gamepad_is_connected(0) && gamepad_button_check_pressed(0, gp_face1));
// Cancel with Esc or B
var cancel_pressed = keyboard_check_pressed(vk_escape) || (gamepad_is_connected(0) && gamepad_button_check_pressed(0, gp_face2));

// Backspace with Backspace key as well
var backspace_pressed = keyboard_check_pressed(vk_backspace);

if (cancel_pressed) {
    cancelled = true;
    exit; // editor will destroy us
}

if (backspace_pressed) {
    if (string_length(input_text) > 0) input_text = string_delete(input_text, string_length(input_text), 1);
}

// If user pressed a key on our on-screen keyboard
if (select_pressed) {
    var idx = cursor_row * grid_cols + cursor_col;
    idx = clamp(idx, 0, array_length(keys) - 1);
    var key = keys[idx];

    if (key == ok_label) {
        output_text = input_text;
        finished    = true;
        exit; // editor will destroy us
    }
    else if (key == "←") {
        if (string_length(input_text) > 0)
            input_text = string_delete(input_text, string_length(input_text), 1);
    }
    else {
        // Append single char
        if (string_length(key) == 1) input_text += key;
    }
}
