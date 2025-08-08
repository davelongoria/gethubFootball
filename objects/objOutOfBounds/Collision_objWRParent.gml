/// @desc Out-of-Bounds ⇆ WR ball-carrier   (2025-06-22 20:12 CDT)

/* 0 ── Fire only when this WR is holding the ball and play isn’t already dead */
if (!other.hasBall)        exit;     // receiver doesn’t own ball
if (objQB.playEnded)       exit;     // whistle already blown

/* 1 ── FEET-ONLY test (bottom 5 px of WR sprite must cross sideline) */
var footTop    = other.bbox_bottom - 5;
var footBottom = other.bbox_bottom;

if (footBottom < bbox_top)    exit;   // feet below OOB strip
if (footTop    > bbox_bottom) exit;   // feet above  OOB strip

/* 2 ── Whistle & mark end of play */
audio_play_sound(sndWhistle, 1, false);

var new_los_x = other.x - 40;        // spot ball at WR’s feet

with (objQB)
{
    playEnded      = true;
    throw_cooldown = 30;             // short pause
    objScrimmageMarker.x = new_los_x;
    can_throw      = false;
}

/* 3 ── Drop the football on the ground at LOS */
with (objFootball)
{
    play_active = false;
    attached_to = noone;
    speed       = 0;
    visible     = true;

    x = objScrimmageMarker.x;
    y = 616;

    /* schedule standard master reset on the next frame */
    alarm[1] = 1;
}

/* 4 ── Clear WR’s ball flags so sprite reverts */
with (other)
{
    hasBall  = false;
    caught   = false;
    sprite_index = Player_run;   // generic jog-back sprite
}

/* 5 ── Clear global flags for next snap */
global.player_has_ball = noone;
global.play_active     = false;
