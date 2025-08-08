event_inherited();
// Example for objLT
scrim_offset = -64;

// OL Variables
block_target = noone;
is_grappling = false;
grapple_timer = 0;
grapple_result = "none"; // "none", "win", "lose"
pancaked = false;
pancake_timer = 0;
speed = 1.1;

// Sprites
spr_idle = sprLinemanPreSnapgry;
spr_run = sprRunGry;
spr_grapple = sprLinemanEngagedgry;
spr_pancaked = sprPancaked;

sprite_index = spr_idle;
image_speed = 0.2;
start_x = x - objScrimmageMarker.x;
start_y = y;
