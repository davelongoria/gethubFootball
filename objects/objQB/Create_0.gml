/// @desc QB Initialize

////////
is_running = false;
// states
hiked            = false;
ballHiked        = false;
playEnded        = false;
can_throw        = true;
throw_cooldown   = 0;
selected_wr      = noone;

// throw mechanics
throw_power_base   = 6;
max_throw_distance = 2200;
max_charge         = 30;
key_hold_timer     = 0;
key_held           = -1;

// scrimmage
line_of_scrimmage_start = objScrimmageMarker.x;
kickoff_spot_x         = 200;

// QB starts with ball in hand
attached_to = id;

// default sprite + sound
sprite_index = sprQbPresnap_gry;
image_xscale = 1;
depth        = -100;
audio_play_sound(sndHut, 5, true);
/* touchdown‐run variables (default = not celebrating) */
celebrate_buffer   = 0;
celebrate_target_x = x;

// --- Pocket Passing Initialization ---
pocket_aiming      = false;
pocket_pulled      = false;
pocket_cooldown    = 0;
//handoff
is_handoff_mode = false;     // Are we running a handoff right now?
handoff_target  = noone;     // Instance ID of the RB to hand off to
handoff_speed   = 3;         // How fast the QB runs to RB for handoff

// Preview arc dots
dot_count          = 12;
pocket_arc         = array_create(dot_count, [0,0]);

// Hand offset (match script values)
hand_offset_x      = 32;
hand_offset_y      = 22;

// Safe seed for lock vars
pocket_lock_dist   = 900;    // largest throw
pocket_lock_arc_h  = 140;    // highest arc
pocket_lock_dir    = 0;
pocket_lock_tx     = x + hand_offset_x;
pocket_lock_ty     = y + hand_offset_y;

