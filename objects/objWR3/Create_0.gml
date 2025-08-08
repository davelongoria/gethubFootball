event_inherited(); // This runs the parent (objWRParent) Create Event
jump_height = 10;  // Custom value for this WR

// This must be unique per WR instance
wr_index = 2; // Set manually for objWR1

/// Create Event: objWRParent

hasBall = false;
caught = false;
jumping = false;
returning = false;
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
