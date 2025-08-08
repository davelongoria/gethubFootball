attached_to = noone;   // Who the football is following
hiked = false;         // Has the play started for this RB?
// === RB Sprite Variables (defaults match WR) ===
spr_idle            = sprRunningBack;
spr_run             = sprRunGry;
spr_run_up          = sprRunUpgry;
spr_run_down        = sprRunDowngry;
spr_run_upright     = sprRunUpRight;
spr_run_with_ball   = sprRunWithBallgry;
spr_celebrate       = sprCelebrateGry;

// === RB Gameplay Variables ===
rb_speed        = 3;
hasBall         = false;
celebrating     = false;
celebrate_buffer   = 0;
celebrate_target_x = x;
prev_x = x;
prev_y = y;
start_y = y;
start_offset_x = x - objScrimmageMarker.x;
//path_index = -1; // For compatibility if you add path logic
assigned_path = "Path5";
route_finished = false;
path_pending = false;
path_started = false;
//path 
route_started = false;
route_cooldown = 0;
