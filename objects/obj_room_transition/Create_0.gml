// Make sure the random seed is randomized - if you already do this elsewhere in your game, or
// you need to keep a specific random seed, you can delete this or comment it out.
randomize();

// Initialise variables
// Room and transition are set when the script room_transition is called
rmtr_room = room;
rmtr_transition = tr_none;
rmtr_speed = 180;

// This variable counts steps in each animation from 0 to 100
rmtr_steps = 0;

// This array stores information needed for some animations
for (var i=0;i<144;i++) {
	rmtr_data[i] = irandom(144);	
}

// This will store a surface in transitions that need it
rmtr_surface = -1;
rmtr_surface_2 = -1;
rmtr_surface_3 = -1;

// This will store a sprite in transitions that need it
rmtr_surface_sprite = -1;

// A variable required for some of the built-in transitions to prevent
// Transitioning to a room twice
rmtr_done = 0;

// Make the precision better for the circular room transitions. You can edit, delete or comment out this
// Line if you want circle precision to be different in your game
draw_set_circle_precision(64);
