/// @desc Out-of-bounds – ball itself  (2025-06-22 16:20 CDT)
/// Out-of-bounds collision for objFootball

// If the play is already ended, don't do anything
if (objQB.playEnded) exit;

// If the ball is still attached (being held, not in air), do nothing
if (objFootball.attached_to != noone) exit;

// --- Rest of your code here ---

/* 1. Use only the feet region of the football for out-of-bounds */
var foot_top    = bbox_bottom - 5;
var foot_bottom = bbox_bottom;

if (foot_bottom < other.bbox_top)  exit;
if (foot_top    > other.bbox_bottom) exit;

/* 2. Whistle & freeze play */
audio_play_sound(sndWhistle, 1, false);

// Do NOT set new_los_x (incomplete pass should not advance the ball)
with (objQB)
{
    playEnded      = true;
    throw_cooldown = 60;
    can_throw      = false;
}

// Reset play as if incomplete
global.play_active     = false;
global.player_has_ball = noone;

with (self) // football
{
    play_active = false;
    attached_to = noone;
    speed       = 0;
    visible     = true;
}

// Optional: set alarm to reset play after a delay
// alarm[1] = 60;


/*
// ── 0.  Ignore if ball attached or play ended ── 
if (objQB.playEnded || other.attached_to != noone) exit;

// ── 1.  FEET-ONLY analog for ball:
//         Use the bottom 5 px of the ball sprite.            ──

var foot_top    = other.bbox_bottom - 5;
var foot_bottom = other.bbox_bottom;

if (foot_bottom < bbox_top)  exit;
if (foot_top    > bbox_bottom) exit;

// ── 2.  Whistle & freeze play ── 
audio_play_sound(sndWhistle, 1, false);

var new_los_x = other.x - 40;

with (objQB)
{
    playEnded      = true;
    throw_cooldown = 60;
    objScrimmageMarker.x = new_los_x;
    can_throw      = false;
}

global.play_active     = false;
global.player_has_ball = noone;

with (other)
{
    play_active = false;
    attached_to = noone;
    speed       = 0;
    visible     = true;
}
objFootball.alarm[1]=60;
