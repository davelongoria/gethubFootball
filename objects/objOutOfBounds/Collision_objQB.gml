/// @desc Out-of-Bounds ⇆ QB  (2025-06-22 20:20 CDT)

/* ─────────────────────────────────────────────
   0.  Trigger only if the QB currently holds the ball
───────────────────────────────────────────── */
if (other.attached_to != other.id) exit;   // QB not carrying ball
if (other.playEnded)              exit;   // play already blown dead

/* ─────────────────────────────────────────────
   1.  FEET-ONLY hit test  (bottom 5 px of QB)
───────────────────────────────────────────── */
var footTop    = other.bbox_bottom - 5;
var footBottom = other.bbox_bottom;

if (footBottom < bbox_top)    exit;
if (footTop    > bbox_bottom) exit;

/* ─────────────────────────────────────────────
   2.  Whistle & spot the ball
───────────────────────────────────────────── */
audio_play_sound(sndWhistle, 1, false);

var new_los_x = other.x - 40;            // spot just inside sideline

/* freeze QB */
other.playEnded      = true;
other.throw_cooldown = 30;
other.can_throw      = false;

/* move LOS marker */
objScrimmageMarker.x = new_los_x;

/* ─────────────────────────────────────────────
   3.  Drop football on the LOS (visible)
───────────────────────────────────────────── */
with (objFootball)
{
    play_active = false;
    attached_to = noone;
    speed       = 0;
    visible     = true;
    x = objScrimmageMarker.x;
    y = 616;

    /* schedule master reset on very next frame */
    alarm[1] = 1;
}

/* ─────────────────────────────────────────────
   4.  Clear globals so next snap can start
───────────────────────────────────────────── */
global.player_has_ball = noone;
global.play_active     = false;
