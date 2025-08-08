// Don't transition if already transitioning
if !(instance_exists(obj_room_transition)) {
	
	// Set the variable _next_room to be whichever room we are not currently in
	var _next_room = (room==rGame) ? rGame : rGame;
	 if audio_is_playing(sndHut){audio_stop_sound(sndHut);}
	// Transition to that room
	// For a list of available transitions see the list of macros in 
	// the script "room_transition". can be 1-40 put current_transition to preview
	//room_transition(_next_room, current_transition, 60);
	room_transition(_next_room,9, 60);
}
