function room_transition(new_room,transition_kind,transition_speed) {
	
	// new_room is the room to go to
	// transition_kind is the type of transition to do (see list of macros below for options)
	// transition_speed is how many steps the transition should take
	
	// You can either use the number or the macro name to get each type of transition.
	#macro tr_none 0
	#macro tr_fade 1
	#macro tr_flash 2
	#macro tr_rectangle_left 3
	#macro tr_rectangle_right 4
	#macro tr_rectangle_up 5
	#macro tr_rectangle_down 6
	#macro tr_horizontal_bars 7
	#macro tr_vertical_bars 8
	#macro tr_static 9
	#macro tr_diagonal_left 10
	#macro tr_diagonal_right 11
	#macro tr_spotlight 12
	#macro tr_center_rectangle 13
	#macro tr_cross_fade 14
	#macro tr_push_left 15
	#macro tr_push_right 16
	#macro tr_push_up 17
	#macro tr_push_down 18
	#macro tr_slide_left 19
	#macro tr_slide_right 20
	#macro tr_slide_up 21
	#macro tr_slide_down 22
	#macro tr_squish_left 23
	#macro tr_squish_right 24
	#macro tr_squish_up 25
	#macro tr_squish_down 26
	#macro tr_portal 27
	#macro tr_grow 28
	#macro tr_doors_vertical 29
	#macro tr_doors_horizontal 30
	#macro tr_splatter 31
	#macro tr_pixelate 32
	#macro tr_shrink 33
	#macro tr_spin 34
	#macro tr_melt 35
	#macro tr_lerp_left 36
	#macro tr_lerp_right 37
	#macro tr_lerp_up 38
	#macro tr_lerp_down 39
	
	// Create an instance of the room transition object and pass it the relevant values.
	var _rtobj = instance_create_depth(0,0,0,obj_room_transition);
	_rtobj.rmtr_room = new_room;
	_rtobj.rmtr_transition = transition_kind;
	_rtobj.rmtr_speed = transition_speed;
	
}
