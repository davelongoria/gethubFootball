event_inherited()
/// Create Event: objWRParent

hasBall = false;
caught = false;
jumping = false;
returning = false;
wr_index = 0; // Set this uniquely in each child (WR1 = 0, WR2 = 1, ...)

celebration_timer = 0;

// Store pre-snap offset for future LOS returns
start_offset_x = x - objScrimmageMarker.x;
start_offset_y = y - objScrimmageMarker.y;

// Animation setup
sprite_index = sorWrPreSnapgry;
image_speed = 0.2;
assigned_path = -1;
flash_timer = 0;
image_blend = c_white;
