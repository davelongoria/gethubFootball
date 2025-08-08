// Press right to go to next logo
if (keyboard_check_pressed(vk_right)) {
    frame += 1;
    if (frame >= total_logos) frame = 0;
}

// Press left to go to previous logo
if (keyboard_check_pressed(vk_left)) {
    frame -= 1;
    if (frame < 0) frame = total_logos - 1;
}
