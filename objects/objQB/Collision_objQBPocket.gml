 in_pocket = true
 
 for (var b = 0; b < 16; b++)
{
    if (gamepad_button_check(0, b))
        show_debug_message("Button held: " + string(b));
}

if (!pocket_aiming && in_pocket && gamepad_button_check_pressed(0, 9))
    pocket_aiming = true;
