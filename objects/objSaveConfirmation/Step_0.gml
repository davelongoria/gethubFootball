/// objSaveConfirmation – Step Event

lifetime -= 1;

if (lifetime < 30) {
    alpha = lifetime / 30;  // Smooth fade out over last 30 steps
}

if (lifetime <= 0) {
    instance_destroy();
}
