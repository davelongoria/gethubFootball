if (!animation_paused) {
    image_index += image_speed; // or whatever method you use
}
if (animation_paused) {
    image_speed = 0;
} else {
    image_speed = .1;
}
