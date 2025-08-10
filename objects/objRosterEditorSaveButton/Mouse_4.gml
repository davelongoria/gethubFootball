/// objRosterEditorSaveButton – Mouse Left Pressed

// Play select sound (if you use it for button clicks)
if (sound_exists(sndPressed)) {
    audio_play_sound(sndPressed, 1, false);
}

// Commit TEMPLATE edits before saving
scr_commit_roster_edits_to_template();

// Now run your existing save logic
scr_save_team_data();

// Show confirmation
if (instance_exists(objSaveConfirmation)) {
    with (objSaveConfirmation) {
        visible = true;
        alarm[0] = room_speed * 2; // Fade out after 2 seconds
    }
} else {
    var conf = instance_create_layer(x, y, "GUI", objSaveConfirmation);
    conf.alarm[0] = room_speed * 2;
}
