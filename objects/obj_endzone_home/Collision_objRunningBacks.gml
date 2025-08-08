/// @desc Touchdown collision  (2025-06-22 17:05 CDT)

/* bail if already scored or carrier lacks ball */
if (global.touchdown_scored) exit;
if (!variable_instance_exists(other,"hasBall") || !other.hasBall) exit;

/* 1 -- mark score & start celebration */
global.touchdown_scored  = true;
global.celebration_timer = 400;          // length of freeze
global.score_home       += 6;            // or score_away in away zone


audio_play_sound(sndTouchdown,1,false);
audio_play_sound(sndCrowd,    1,true);

global.play_active = false;   // <─ NEW ── makes other WRs stop

/* 2 -- tell the carrier to keep running to end-zone middle */
with (other)
{
    celebrate_buffer   = 30;                         // keep legs moving
    celebrate_target_x = (bbox_left + bbox_right)/2; // end-zone centre
}

/* 3 -- freeze play from QB’s perspective */
with (objQB)
{
    playEnded      = true;
    can_throw      = false;
    throw_cooldown = global.celebration_timer;
}

/* 4 -- schedule master reset after celebration (one shot) */
with (objFootball) alarm[1] = global.celebration_timer + 1;
alarm[0]=60;
