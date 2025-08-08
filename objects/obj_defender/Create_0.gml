// obj_defender Create Event
start_x = x - objScrimmageMarker.x;
start_y = y;

// Movement attributes
speed = 1.2;
role = "none";
state = "idle";

// Sprite Assignments (centralized)
spr_idle = sprStandingIdlegry;        // General default idle
spr_idleLB = sprStandingIdlegry;           // Linebacker idle
spr_idleCB = sprStandingIdlegry;           // Cornerback idle
spr_idleDL = sprLinemanPreSnapgry;           // Defensive line idle

spr_run = sprRunGry;
spr_dive = sprDiveGry;
spr_jump = sprJumpgry;
spr_runDown = sprRunDowngry;
spr_runDownRight = sprRunGry;
spr_runUpRight = sprRunUpRight;
spr_runUp = sprRunUpgry;
spr_grapple = sprLinemanEngagedgry;
spr_pancaked = sprPancaked;
spr_run_ball = sprRunWithBallgry;
speed = 1.2;
role = "none";
state = "idle";

block_target = noone;



sprite_index = spr_idle;
image_speed = 0.2;

reaction_time = 0.2;
alarm[0] = reaction_time * room_speed;
