/// Collision Event: objFootball (for objRunningBacks parent)

// Only catch if play is active, ball is not attached, and you don't already have the ball
if (global.play_active && other.attached_to == noone && global.player_has_ball != id)
{
    // You take possession
    attached_to = id;
    global.player_has_ball = id;
    hasBall = true; // If you use this variable

    // Set sprite for running with ball (customize for your RBs)
    sprite_index = sprRunWithBallgry;

    // Lock football to you and "deactivate" its physics
    with (other)
    {
        attached_to = id;
        visible = false;
        speed = 0;
        direction = 0;
        // Optionally reset ball arc/visuals/etc here
    }

    audio_play_sound(sndCaught2, 1, false);
}
