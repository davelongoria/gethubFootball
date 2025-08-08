/// objComingSoonPopup - Step Event

if (keyboard_check_pressed(vk_anykey) ||
    gamepad_button_check_pressed(0, gp_face1) ||
    gamepad_button_check_pressed(0, gp_face2) ||
    gamepad_button_check_pressed(0, gp_start) ||
    gamepad_button_check_pressed(0, gp_shoulderl) ||
    gamepad_button_check_pressed(0, gp_shoulderr) ||
    gamepad_button_check_pressed(0, gp_padl) ||
    gamepad_button_check_pressed(0, gp_padr) ||
    gamepad_button_check_pressed(0, gp_padu) ||
    gamepad_button_check_pressed(0, gp_padd)) {
    global.ui_overlay_active = false;
    global.coming_soon_active = false;
    instance_destroy();
}
