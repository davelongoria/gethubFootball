/// @desc objFootball Create Event
x = objScrimmageMarker.x;
y = 616;

speed = 0;
direction = 0;
global.play_active = false;
attached_to = noone;
visible = true;

visual_z = 0;
visual_arc_time = 0;
visual_arc_total = 0;
visual_arc_peak = 0;

target_x = x;
target_y = y;

alarm_buffer_timer = -1;
alarm[1] = -1;
/* was that last pass completed? */
pass_was_caught = false;
