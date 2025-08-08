if !(instance_exists(obj_room_transition))
		{
	       var _next_room = (room==rGame) ? rGame : rGame;
	       if audio_is_playing(sndHut){audio_stop_sound(sndHut);}
	       room_transition(_next_room,9, 60);
		   global.play_is_run = false;
         }