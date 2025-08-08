// Count up the steps in the animation
rmtr_steps++;

// If the animation is half way through (which is when the screen will be obscured and the 
// animation is at its peak) - go to the target room.
var rmtr_half = floor(rmtr_speed/2);
if (rmtr_steps == rmtr_half && !rmtr_done) {
	
	room_goto( rmtr_room );
	
} else if (rmtr_steps > rmtr_speed) {
	
// If the animation has ended, destroy this instance.
	
	instance_destroy();	
	
}

// Collect information about the screen size for transitioning
var _trdw = display_get_gui_width();
var _trdh = display_get_gui_height();

// Collect information about the current draw settings so we can reset them later and not interfere
// With other drawing in the game
var _tr_old_color = draw_get_color();
var _tr_old_alpha = draw_get_alpha();
var _tr_old_interpolation = gpu_get_tex_filter();

// Below here, perfom different tasks per animation
switch (rmtr_transition) {

	case tr_none:
		room_goto( rmtr_room );
		instance_destroy();	
	break;
	
	case tr_fade:
		if (rmtr_steps<=rmtr_half) {
			draw_set_alpha(rmtr_steps/rmtr_half);
		} else {
			draw_set_alpha(1-((rmtr_steps-rmtr_half)/rmtr_half));
		}
		draw_set_color(c_black);
		draw_rectangle(-1,-1,_trdw+1,_trdh+1,0);
	break;
	
	case tr_flash:
		if (rmtr_steps<=rmtr_half) {
			draw_set_alpha(rmtr_steps/rmtr_half);
		} else {
			draw_set_alpha(1-((rmtr_steps-rmtr_half)/rmtr_half));
		}
		draw_set_color(c_white);
		draw_rectangle(-1,-1,_trdw+1,_trdh+1,0);
	break;
	
	case tr_rectangle_left:
		draw_set_color(c_black);
		if (rmtr_steps<=rmtr_half) {
			var rmtr_pc = rmtr_steps/rmtr_half;
			draw_rectangle( _trdw - (_trdw*rmtr_pc) ,-1, _trdw+1, _trdh+1,0);
		} else {
			var rmtr_pc = 1-((rmtr_steps-rmtr_half)/rmtr_half);
			draw_rectangle( -1 ,-1, _trdw*rmtr_pc, _trdh+1,0);
		}
	break;
	
	case tr_rectangle_right:
		draw_set_color(c_black);
		if (rmtr_steps<=rmtr_half) {
			var rmtr_pc = rmtr_steps/rmtr_half;
			draw_rectangle( -1 ,-1, _trdw*rmtr_pc, _trdh+1,0);
		} else {
			var rmtr_pc = 1-((rmtr_steps-rmtr_half)/rmtr_half);
			draw_rectangle( _trdw - (_trdw*rmtr_pc) ,-1, _trdw+1, _trdh+1,0);
		}
	break;
	
	case tr_rectangle_up:
		draw_set_color(c_black);
		if (rmtr_steps<=rmtr_half) {
			var rmtr_pc = rmtr_steps/rmtr_half;
			draw_rectangle( -1 ,_trdh - (_trdh*rmtr_pc), _trdw+1, _trdh+1,0);
		} else {
			var rmtr_pc = 1-((rmtr_steps-rmtr_half)/rmtr_half);
			draw_rectangle( -1 ,-1, _trdw+1, _trdh*rmtr_pc,0);
		}
	break;
	
	case tr_rectangle_down:
		draw_set_color(c_black);
		if (rmtr_steps<=rmtr_half) {
			var rmtr_pc = rmtr_steps/rmtr_half;
			draw_rectangle( -1 ,-1, _trdw+1, _trdh*rmtr_pc,0);
		} else {
			var rmtr_pc = 1-((rmtr_steps-rmtr_half)/rmtr_half);
			draw_rectangle( -1 ,_trdh - (_trdh*rmtr_pc), _trdw+1, _trdh+1,0);
		}
	break;
	
	case tr_horizontal_bars:
		draw_set_color(c_black);
		var rmtr_bh = _trdh / 8;
		if (rmtr_steps<=rmtr_half) {
			var rmtr_pc = rmtr_steps/rmtr_half;
			draw_rectangle( _trdw - (_trdw*rmtr_pc) ,-1, _trdw+1, rmtr_bh,0);
			draw_rectangle( -1 ,rmtr_bh, _trdw*rmtr_pc, (rmtr_bh*2),0);
			draw_rectangle( _trdw - (_trdw*rmtr_pc) ,(rmtr_bh*2), _trdw+1, (rmtr_bh*3),0);
			draw_rectangle( -1 ,(rmtr_bh*3), _trdw*rmtr_pc, (rmtr_bh*4),0);
			draw_rectangle( _trdw - (_trdw*rmtr_pc) ,(rmtr_bh*4), _trdw+1, (rmtr_bh*5),0);
			draw_rectangle( -1 ,(rmtr_bh*5), _trdw*rmtr_pc, (rmtr_bh*6),0);
			draw_rectangle( _trdw - (_trdw*rmtr_pc) ,(rmtr_bh*6), _trdw+1, (rmtr_bh*7),0);
			draw_rectangle( -1 ,(rmtr_bh*7), _trdw*rmtr_pc, (rmtr_bh*8),0);
		} else {
			var rmtr_pc = 1-((rmtr_steps-rmtr_half)/rmtr_half);
			draw_rectangle( -1 ,-1, _trdw*rmtr_pc, rmtr_bh,0);
			draw_rectangle( _trdw - (_trdw*rmtr_pc) ,rmtr_bh, _trdw+1, (rmtr_bh*2),0);
			draw_rectangle( -1 ,(rmtr_bh*2), _trdw*rmtr_pc, (rmtr_bh*3),0);
			draw_rectangle( _trdw - (_trdw*rmtr_pc) ,(rmtr_bh*3), _trdw+1, (rmtr_bh*4),0);
			draw_rectangle( -1 ,(rmtr_bh*4), _trdw*rmtr_pc, (rmtr_bh*5),0);
			draw_rectangle( _trdw - (_trdw*rmtr_pc) ,(rmtr_bh*5), _trdw+1, (rmtr_bh*6),0);
			draw_rectangle( -1 ,(rmtr_bh*6), _trdw*rmtr_pc, (rmtr_bh*7),0);
			draw_rectangle( _trdw - (_trdw*rmtr_pc) ,(rmtr_bh*7), _trdw+1, (rmtr_bh*8),0);
		}
	break;
	
	case tr_vertical_bars:
		draw_set_color(c_black);
		var rmtr_bv = _trdw / 8;
		if (rmtr_steps<=rmtr_half) {
			var rmtr_pc = rmtr_steps/rmtr_half;
			draw_rectangle( -1 ,_trdh - (_trdh*rmtr_pc), rmtr_bv, _trdh+1,0);
			draw_rectangle( rmtr_bv ,-1, (rmtr_bv*2), _trdh*rmtr_pc,0);
			draw_rectangle( (rmtr_bv*2) ,_trdh - (_trdh*rmtr_pc), (rmtr_bv*3), _trdh+1,0);
			draw_rectangle( (rmtr_bv*3) ,-1, (rmtr_bv*4), _trdh*rmtr_pc,0);
			draw_rectangle( (rmtr_bv*4) ,_trdh - (_trdh*rmtr_pc), (rmtr_bv*5), _trdh+1,0);
			draw_rectangle( (rmtr_bv*5) ,-1, (rmtr_bv*6), _trdh*rmtr_pc,0);
			draw_rectangle( (rmtr_bv*6) ,_trdh - (_trdh*rmtr_pc), (rmtr_bv*7), _trdh+1,0);
			draw_rectangle( (rmtr_bv*7) ,-1, (rmtr_bv*8), _trdh*rmtr_pc,0);
		} else {
			var rmtr_pc = 1-((rmtr_steps-rmtr_half)/rmtr_half);
			draw_rectangle( -1 ,-1, rmtr_bv, _trdh*rmtr_pc,0);
			draw_rectangle( rmtr_bv ,_trdh - (_trdh*rmtr_pc), (rmtr_bv*2), _trdh+1,0);
			draw_rectangle( (rmtr_bv*2) ,-1, (rmtr_bv*3), _trdh*rmtr_pc,0);
			draw_rectangle( (rmtr_bv*3) ,_trdh - (_trdh*rmtr_pc), (rmtr_bv*4), _trdh+1,0);
			draw_rectangle( (rmtr_bv*4) ,-1, (rmtr_bv*5), _trdh*rmtr_pc,0);
			draw_rectangle( (rmtr_bv*5) ,_trdh - (_trdh*rmtr_pc), (rmtr_bv*6), _trdh+1,0);
			draw_rectangle( (rmtr_bv*6) ,-1, (rmtr_bv*7), _trdh*rmtr_pc,0);
			draw_rectangle( (rmtr_bv*7) ,_trdh - (_trdh*rmtr_pc), (rmtr_bv*8), _trdh+1,0);
		}
	break;
	
	case tr_static:
		draw_set_color(c_black);
		var rmtr_sqw = _trdw / 16;
		var rmtr_sqh = _trdh / 9;
		var rmtr_trg = rmtr_half/144;
		for (var i=0;i<144;i++) {
			if (rmtr_steps<=rmtr_half) {
				if ((rmtr_data[i]*rmtr_trg)<=rmtr_steps) {
					draw_rectangle( (i mod 16) * rmtr_sqw, (i div 16) * rmtr_sqh, ((i mod 16)+1)*rmtr_sqw, ((i div 16)+1) * rmtr_sqh, 0);
				}
			} else {
				if ((rmtr_data[i]*rmtr_trg)>=(rmtr_steps-rmtr_half)) {
					draw_rectangle( (i mod 16) * rmtr_sqw, (i div 16) * rmtr_sqh, ((i mod 16)+1)*rmtr_sqw, ((i div 16)+1) * rmtr_sqh, 0);
				}
			}
		}
	break;
	
	case tr_diagonal_left:
		var rmtr_pc = rmtr_steps/rmtr_speed;
		var rmtr_left = _trdw - ((_trdw*4)*rmtr_pc);
		draw_set_color(c_black);
		draw_triangle(rmtr_left,_trdh+1,rmtr_left+(_trdw/2),-1,rmtr_left+(_trdw/2),_trdh+1,0);
		draw_rectangle(rmtr_left+(_trdw/2),-1,rmtr_left+(_trdw*2),_trdh+1,0);
		draw_triangle(rmtr_left+(_trdw*2),-1,rmtr_left+(_trdw*2),_trdh+1,rmtr_left+(_trdw*2.5),-1,0);
	break;
	
	case tr_diagonal_right:
		var rmtr_pc = rmtr_steps/rmtr_speed;
		var rmtr_left = ((_trdw*4)*rmtr_pc)-(_trdw*3);
		draw_set_color(c_black);
		draw_triangle(rmtr_left,_trdh+1,rmtr_left+(_trdw/2),-1,rmtr_left+(_trdw/2),_trdh+1,0);
		draw_rectangle(rmtr_left+(_trdw/2),-1,rmtr_left+(_trdw*2),_trdh+1,0);
		draw_triangle(rmtr_left+(_trdw*2),-1,rmtr_left+(_trdw*2),_trdh+1,rmtr_left+(_trdw*2.5),-1,0);
	break;
	
	case tr_spotlight:
		var rmtr_max_radius = max(_trdw,_trdh)*1.05;
		var rmtr_radius = 0;
		if (rmtr_steps<=rmtr_half) {
			rmtr_radius = rmtr_max_radius-((rmtr_steps/rmtr_half)*rmtr_max_radius);
		} else {
			rmtr_radius = ((rmtr_steps-rmtr_half)/rmtr_half)*rmtr_max_radius;
		}
		if !(surface_exists(rmtr_surface)) {
			rmtr_surface = surface_create(_trdw,_trdh);	
		}
		surface_set_target(rmtr_surface);
		draw_clear_alpha(c_black,0);
		draw_set_color(c_black);
		draw_rectangle(-1,-1,_trdw+1,_trdh+1,0);
		gpu_set_blendmode(bm_subtract);
		draw_set_color(c_white);
		draw_circle(_trdw/2,_trdh/2,rmtr_radius,0);
		gpu_set_blendmode(bm_normal);
		surface_reset_target();
		draw_surface(rmtr_surface,0,0);
	break;
	
	case tr_center_rectangle:
		var _trdwh = (_trdw/2);
		var _trdhh = (_trdh/2);
		var rmtr_pc = 0;
		var rmtr_pc_2 = 0;
		if !(surface_exists(rmtr_surface)) {
			rmtr_surface = surface_create(_trdw,_trdh);	
		}
		if (rmtr_steps<=rmtr_half) {
			var rmtr_pc = rmtr_steps/rmtr_half;
		} else {
			var rmtr_pc = 1;
			var rmtr_pc_2 = (rmtr_steps-rmtr_half)/rmtr_half;
		}
		surface_set_target(rmtr_surface);
		draw_clear_alpha(c_black,0);
		draw_set_color(c_black);
		draw_rectangle( _trdwh - (_trdwh*rmtr_pc), _trdhh - (_trdhh*rmtr_pc), _trdwh + (_trdwh*rmtr_pc), _trdhh + (_trdhh*rmtr_pc), 0);	
		if (rmtr_steps>rmtr_half) {
			gpu_set_blendmode(bm_subtract);
			draw_set_color(c_white);
			draw_rectangle( _trdwh - (_trdwh*rmtr_pc_2), _trdhh - (_trdhh*rmtr_pc_2), _trdwh + (_trdwh*rmtr_pc_2), _trdhh + (_trdhh*rmtr_pc_2), 0);	
			gpu_set_blendmode(bm_normal);
		}
		surface_reset_target();
		draw_surface(rmtr_surface,0,0);
	break;
	
	case tr_cross_fade:
		if !(surface_exists(rmtr_surface)) {
			rmtr_surface = surface_create(_trdw,_trdh);	
		}
		if !(surface_exists(rmtr_surface_2)) {
			rmtr_surface_2 = surface_create(_trdw,_trdh);	
		}
		if (rmtr_done<1) {
			surface_set_target(rmtr_surface);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
			room_goto(rmtr_room);
			rmtr_done = 1;
		} else {
			surface_set_target(rmtr_surface_2);
			draw_clear_alpha(c_black,0);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
		}
		draw_surface(rmtr_surface,0,0);
		draw_surface_ext(rmtr_surface_2,0,0,1,1,0,c_white, rmtr_steps / rmtr_speed);
	break;
	
	case tr_push_left:
		if !(surface_exists(rmtr_surface)) {
			rmtr_surface = surface_create(_trdw,_trdh);	
		}
		if !(surface_exists(rmtr_surface_2)) {
			rmtr_surface_2 = surface_create(_trdw,_trdh);	
		}
		if (rmtr_done<1) {
			surface_set_target(rmtr_surface);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
			room_goto(rmtr_room);
			rmtr_done = 1;
		} else {
			surface_set_target(rmtr_surface_2);
			draw_clear_alpha(c_black,0);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
		}
		draw_surface(rmtr_surface,0 - (_trdw*(rmtr_steps/rmtr_speed)),0);
		draw_surface(rmtr_surface_2,_trdw - (_trdw*(rmtr_steps/rmtr_speed)),0);
	break;
	
	case tr_push_right:
		if !(surface_exists(rmtr_surface)) {
			rmtr_surface = surface_create(_trdw,_trdh);	
		}
		if !(surface_exists(rmtr_surface_2)) {
			rmtr_surface_2 = surface_create(_trdw,_trdh);	
		}
		if (rmtr_done<1) {
			surface_set_target(rmtr_surface);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
			room_goto(rmtr_room);
			rmtr_done = 1;
		} else {
			surface_set_target(rmtr_surface_2);
			draw_clear_alpha(c_black,0);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
		}
		draw_surface(rmtr_surface,0 + (_trdw*(rmtr_steps/rmtr_speed)),0);
		draw_surface(rmtr_surface_2,(_trdw*(rmtr_steps/rmtr_speed)) -_trdw,0);
	break;
	
	case tr_push_up:
		if !(surface_exists(rmtr_surface)) {
			rmtr_surface = surface_create(_trdw,_trdh);	
		}
		if !(surface_exists(rmtr_surface_2)) {
			rmtr_surface_2 = surface_create(_trdw,_trdh);	
		}
		if (rmtr_done<1) {
			surface_set_target(rmtr_surface);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
			room_goto(rmtr_room);
			rmtr_done = 1;
		} else {
			surface_set_target(rmtr_surface_2);
			draw_clear_alpha(c_black,0);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
		}
		draw_surface(rmtr_surface,0,0  - (_trdh*(rmtr_steps/rmtr_speed)));
		draw_surface(rmtr_surface_2,0 , _trdh - (_trdh*(rmtr_steps/rmtr_speed)));
	break;
	
	case tr_push_down:
		if !(surface_exists(rmtr_surface)) {
			rmtr_surface = surface_create(_trdw,_trdh);	
		}
		if !(surface_exists(rmtr_surface_2)) {
			rmtr_surface_2 = surface_create(_trdw,_trdh);	
		}
		if (rmtr_done<1) {
			surface_set_target(rmtr_surface);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
			room_goto(rmtr_room);
			rmtr_done = 1;
		} else {
			surface_set_target(rmtr_surface_2);
			draw_clear_alpha(c_black,0);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
		}
		draw_surface(rmtr_surface,0,0  + (_trdh*(rmtr_steps/rmtr_speed)));
		draw_surface(rmtr_surface_2,0 ,(_trdh*(rmtr_steps/rmtr_speed))-_trdh);
	break;
	
	case tr_slide_left:
		if !(surface_exists(rmtr_surface)) {
			rmtr_surface = surface_create(_trdw,_trdh);	
		}
		if !(surface_exists(rmtr_surface_2)) {
			rmtr_surface_2 = surface_create(_trdw,_trdh);	
		}
		if (rmtr_done<1) {
			surface_set_target(rmtr_surface);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
			room_goto(rmtr_room);
			rmtr_done = 1;
		} else {
			surface_set_target(rmtr_surface_2);
			draw_clear_alpha(c_black,0);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
		}
		draw_surface(rmtr_surface,0,0);
		draw_surface(rmtr_surface_2,_trdw - (_trdw*(rmtr_steps/rmtr_speed)),0);
	break;
	
	case tr_slide_right:
		if !(surface_exists(rmtr_surface)) {
			rmtr_surface = surface_create(_trdw,_trdh);	
		}
		if !(surface_exists(rmtr_surface_2)) {
			rmtr_surface_2 = surface_create(_trdw,_trdh);	
		}
		if (rmtr_done<1) {
			surface_set_target(rmtr_surface);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
			room_goto(rmtr_room);
			rmtr_done = 1;
		} else {
			surface_set_target(rmtr_surface_2);
			draw_clear_alpha(c_black,0);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
		}
		draw_surface(rmtr_surface,0,0);
		draw_surface(rmtr_surface_2,(_trdw*(rmtr_steps/rmtr_speed)) -_trdw,0);
	break;
	
	case tr_slide_up:
		if !(surface_exists(rmtr_surface)) {
			rmtr_surface = surface_create(_trdw,_trdh);	
		}
		if !(surface_exists(rmtr_surface_2)) {
			rmtr_surface_2 = surface_create(_trdw,_trdh);	
		}
		if (rmtr_done<1) {
			surface_set_target(rmtr_surface);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
			room_goto(rmtr_room);
			rmtr_done = 1;
		} else {
			surface_set_target(rmtr_surface_2);
			draw_clear_alpha(c_black,0);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
		}
		draw_surface(rmtr_surface,0,0);
		draw_surface(rmtr_surface_2,0 , _trdh - (_trdh*(rmtr_steps/rmtr_speed)));
	break;
	
	case tr_slide_down:
		if !(surface_exists(rmtr_surface)) {
			rmtr_surface = surface_create(_trdw,_trdh);	
		}
		if !(surface_exists(rmtr_surface_2)) {
			rmtr_surface_2 = surface_create(_trdw,_trdh);	
		}
		if (rmtr_done<1) {
			surface_set_target(rmtr_surface);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
			room_goto(rmtr_room);
			rmtr_done = 1;
		} else {
			surface_set_target(rmtr_surface_2);
			draw_clear_alpha(c_black,0);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
		}
		draw_surface(rmtr_surface,0,0);
		draw_surface(rmtr_surface_2,0 ,(_trdh*(rmtr_steps/rmtr_speed))-_trdh);
	break;
	
	case tr_squish_left:
		if !(surface_exists(rmtr_surface)) {
			rmtr_surface = surface_create(_trdw,_trdh);	
		}
		if !(surface_exists(rmtr_surface_2)) {
			rmtr_surface_2 = surface_create(_trdw,_trdh);	
		}
		if (rmtr_done<1) {
			surface_set_target(rmtr_surface);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
			room_goto(rmtr_room);
			rmtr_done = 1;
		} else {
			surface_set_target(rmtr_surface_2);
			draw_clear_alpha(c_black,0);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
		}
		draw_surface_ext(rmtr_surface,0,0,1 - (rmtr_steps/rmtr_speed),1,0,c_white,1);
		draw_surface_ext(rmtr_surface_2,_trdw - ((rmtr_steps/rmtr_speed)*_trdw),0,(rmtr_steps/rmtr_speed),1,0,c_white,1);
	break;
	
	case tr_squish_right:
		if !(surface_exists(rmtr_surface)) {
			rmtr_surface = surface_create(_trdw,_trdh);	
		}
		if !(surface_exists(rmtr_surface_2)) {
			rmtr_surface_2 = surface_create(_trdw,_trdh);	
		}
		if (rmtr_done<1) {
			surface_set_target(rmtr_surface);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
			room_goto(rmtr_room);
			rmtr_done = 1;
		} else {
			surface_set_target(rmtr_surface_2);
			draw_clear_alpha(c_black,0);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
		}
		draw_surface_ext(rmtr_surface,((rmtr_steps/rmtr_speed)*_trdw),0,1 - (rmtr_steps/rmtr_speed),1,0,c_white,1);
		draw_surface_ext(rmtr_surface_2,0,0,(rmtr_steps/rmtr_speed),1,0,c_white,1);
	break;
	
	case tr_squish_up:
		if !(surface_exists(rmtr_surface)) {
			rmtr_surface = surface_create(_trdw,_trdh);	
		}
		if !(surface_exists(rmtr_surface_2)) {
			rmtr_surface_2 = surface_create(_trdw,_trdh);	
		}
		if (rmtr_done<1) {
			surface_set_target(rmtr_surface);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
			room_goto(rmtr_room);
			rmtr_done = 1;
		} else {
			surface_set_target(rmtr_surface_2);
			draw_clear_alpha(c_black,0);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
		}
		draw_surface_ext(rmtr_surface,0,0,1,1 - (rmtr_steps/rmtr_speed),0,c_white,1);
		draw_surface_ext(rmtr_surface_2,0,_trdh - ((rmtr_steps/rmtr_speed)*_trdh),1,(rmtr_steps/rmtr_speed),0,c_white,1);
	break;
	
	case tr_squish_down:
		if !(surface_exists(rmtr_surface)) {
			rmtr_surface = surface_create(_trdw,_trdh);	
		}
		if !(surface_exists(rmtr_surface_2)) {
			rmtr_surface_2 = surface_create(_trdw,_trdh);	
		}
		if (rmtr_done<1) {
			surface_set_target(rmtr_surface);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
			room_goto(rmtr_room);
			rmtr_done = 1;
		} else {
			surface_set_target(rmtr_surface_2);
			draw_clear_alpha(c_black,0);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
		}
		draw_surface_ext(rmtr_surface,0,((rmtr_steps/rmtr_speed)*_trdh),1,1 - (rmtr_steps/rmtr_speed),0,c_white,1);
		draw_surface_ext(rmtr_surface_2,0,0,1,(rmtr_steps/rmtr_speed),0,c_white,1);
	break;
	
	case tr_portal:
	
		var rmtr_max_radius = max(_trdw,_trdh)*1.05;
		var rmtr_radius = (rmtr_steps / rmtr_speed) * rmtr_max_radius;
		if !(surface_exists(rmtr_surface_3)) {
			rmtr_surface_3 = surface_create(_trdw,_trdh);	
		}
		
		surface_set_target(rmtr_surface_3);
		draw_clear_alpha(c_black,0);
		draw_set_color(c_white);
		draw_rectangle(-1,-1,_trdw+1,_trdh+1,0);
		gpu_set_blendmode(bm_subtract);
		draw_set_color(c_white);
		draw_circle(_trdw/2,_trdh/2,rmtr_radius,0);
		gpu_set_blendmode(bm_normal);
		surface_reset_target();
		
		if !(surface_exists(rmtr_surface)) {
			rmtr_surface = surface_create(_trdw,_trdh);	
		}
		if !(surface_exists(rmtr_surface_2)) {
			rmtr_surface_2 = surface_create(_trdw,_trdh);	
		}
			
		if (rmtr_done<1) {
			surface_set_target(rmtr_surface);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
			room_goto(rmtr_room);
			rmtr_done = 1;
		} else if (rmtr_done) {
			surface_set_target(rmtr_surface_2);
			draw_clear_alpha(c_black,0);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			gpu_set_blendmode(bm_subtract);
			draw_surface(rmtr_surface_3,0,0);
			gpu_set_blendmode(bm_normal);
			surface_reset_target();
		}
		draw_surface(rmtr_surface,0,0);
		draw_surface(rmtr_surface_2,0,0);
	break;
	
	case tr_grow:
		var rmtr_pc = (rmtr_steps / rmtr_speed);
		if !(surface_exists(rmtr_surface)) {
			rmtr_surface = surface_create(_trdw,_trdh);	
		}
		if !(surface_exists(rmtr_surface_2)) {
			rmtr_surface_2 = surface_create(_trdw,_trdh);	
		}
		if (rmtr_done<1) {
			surface_set_target(rmtr_surface);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
			room_goto(rmtr_room);
			rmtr_done = 1;
		} else {
			surface_set_target(rmtr_surface_2);
			draw_clear_alpha(c_black,0);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
		}
		draw_surface(rmtr_surface,0,0);
		draw_surface_ext(rmtr_surface_2,(_trdw/2) - ((_trdw/2)*rmtr_pc),(_trdh/2) - ((_trdh/2)*rmtr_pc),rmtr_pc,rmtr_pc,0,c_white,1);
	break;
	
	case tr_doors_vertical:
		draw_set_color(c_black);
		if (rmtr_steps<=rmtr_half) {
			var rmtr_pc = rmtr_steps/rmtr_half;
		} else {
			var rmtr_pc = 1-((rmtr_steps-rmtr_half)/rmtr_half);
		}
		draw_rectangle( -1 ,-1, _trdw * rmtr_pc, _trdh+1,0);
		draw_rectangle( _trdw - (_trdw * rmtr_pc) ,-1, _trdw+1, _trdh+1,0);
	break;
	
	case tr_doors_horizontal:
		draw_set_color(c_black);
		if (rmtr_steps<=rmtr_half) {
			var rmtr_pc = rmtr_steps/rmtr_half;
		} else {
			var rmtr_pc = 1-((rmtr_steps-rmtr_half)/rmtr_half);
		}
		draw_rectangle( -1 ,-1, _trdw+1, _trdh * rmtr_pc,0);
		draw_rectangle( -1 ,_trdh - (_trdh * rmtr_pc), _trdw+1, _trdh+1,0);
	break;
	
	case tr_splatter:
		draw_set_color(c_black);
		var rmtr_sqw = max(_trdw / 16,_trdh / 16)*1.5;
		var rmtr_sqh = max(_trdw / 16,_trdh / 16)*1.5;
		var rmtr_offset = rmtr_sqw*0.75;
		var rmtr_trg = rmtr_half/144;
		for (var i=0;i<144;i++) {
			if (rmtr_steps<=rmtr_half) {
				if ((rmtr_data[i]*rmtr_trg)<=rmtr_steps) {
					draw_ellipse( ((i mod 16) * rmtr_sqw)-rmtr_offset, ((i div 16) * rmtr_sqh)-rmtr_offset, (((i mod 16)+1)*rmtr_sqw)+rmtr_offset, (((i div 16)+1) * rmtr_sqh)+rmtr_offset, 0);
				}
			} else {
				if ((rmtr_data[i]*rmtr_trg)>=(rmtr_steps-rmtr_half)) {
					draw_ellipse( ((i mod 16) * rmtr_sqw)-rmtr_offset, ((i div 16) * rmtr_sqh)-rmtr_offset, (((i mod 16)+1)*rmtr_sqw)+rmtr_offset, (((i div 16)+1) * rmtr_sqh)+rmtr_offset, 0);
				}
			}
		}
	break;
	
	case tr_pixelate:
	
		if !(surface_exists(rmtr_surface)) {
			
			rmtr_surface = surface_create(_trdw,_trdh);	
			
		}

		gpu_set_tex_filter(false);
		var rmtr_sw = _trdw;
		var rmtr_sh = _trdh;
		var rmtr_increments = (_trdw-8) / rmtr_half;
		var rmtr_ar = _trdh / _trdw;
		
		if (rmtr_steps<=rmtr_half) {
			
			var rmtr_sw = max(ceil( _trdw - (rmtr_increments * rmtr_steps) ),8);
			var rmtr_sh = max(ceil( rmtr_sw * rmtr_ar),8);
			surface_resize(rmtr_surface,rmtr_sw,rmtr_sh);
			surface_set_target(rmtr_surface);
			draw_clear_alpha(c_black,0);
			draw_surface_ext(application_surface,0,0,rmtr_sw/_trdw,rmtr_sh/_trdh,0,c_white,1);
			surface_reset_target();
			
		} else {
			
			var rmtr_steps_2 = rmtr_half-(rmtr_steps-rmtr_half);
			var rmtr_sw = max(ceil( _trdw - (rmtr_increments * rmtr_steps_2) ),8);
			var rmtr_sh = max(ceil( rmtr_sw * rmtr_ar),8);
			surface_resize(rmtr_surface,rmtr_sw,rmtr_sh);
			surface_set_target(rmtr_surface);
			draw_clear_alpha(c_black,0);
			draw_surface_ext(application_surface,0,0,rmtr_sw/_trdw,rmtr_sh/_trdh,0,c_white,1);
			surface_reset_target();
			
		}
		
		draw_surface_ext(rmtr_surface,0,0,_trdw/rmtr_sw,_trdh/rmtr_sh,0,c_white,1);

	break;
	
	case tr_shrink:
		if !(surface_exists(rmtr_surface)) {
			
			rmtr_surface = surface_create(_trdw,_trdh);	
			
		}
		if !(rmtr_done) {
			surface_set_target(rmtr_surface);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
			room_goto(rmtr_room);
			rmtr_done = 1;
		}
		var rmtr_sc = 1-(rmtr_steps/rmtr_speed);
		var _trdwh = _trdw/2;
		var _trdhh = _trdh/2;
		draw_surface_ext(rmtr_surface,_trdwh - (_trdwh*rmtr_sc),_trdhh - (_trdhh*rmtr_sc),rmtr_sc,rmtr_sc,0,c_white,1);
	break;
	
	case tr_spin:
		var rmtr_pc = rmtr_steps / rmtr_speed;
		if !(surface_exists(rmtr_surface)) {
			rmtr_surface = surface_create(_trdw,_trdh);	
		}
		if !(surface_exists(rmtr_surface_2)) {
			rmtr_surface_2 = surface_create(_trdw,_trdh);	
		}
		if (rmtr_done<1) {
			surface_set_target(rmtr_surface);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
			room_goto(rmtr_room);
			rmtr_done = 1;
		} else if (rmtr_done<2) {
			surface_set_target(rmtr_surface_2);
			draw_clear_alpha(c_black,0);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
			rmtr_surface_sprite = sprite_create_from_surface(rmtr_surface_2,0,0,_trdw,_trdh,false,false,ceil(_trdw/2),ceil(_trdh/2));
			rmtr_done = 2;
		}
		draw_surface(rmtr_surface,0,0);
		if (sprite_exists(rmtr_surface_sprite)) {
			draw_sprite_ext(rmtr_surface_sprite,0,_trdw/2,_trdh/2,rmtr_pc,rmtr_pc,rmtr_pc * 1080,c_white,1);
		}
	break;
	
	case tr_melt:
		var rmtr_pc = rmtr_steps / rmtr_speed;
		if !(surface_exists(rmtr_surface)) {
			rmtr_surface = surface_create(_trdw,_trdh);	
		}
		if (rmtr_done<1) {
			surface_set_target(rmtr_surface);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
			rmtr_surface_sprite = sprite_create_from_surface(rmtr_surface,0,0,_trdw,_trdh,false,false,ceil(_trdw/2),_trdh);
			room_goto(rmtr_room);
			rmtr_done = 1;
		} 
		if (sprite_exists(rmtr_surface_sprite)) {
			draw_sprite_ext(rmtr_surface_sprite,0,_trdw/2,_trdh,1+rmtr_pc,1-(rmtr_pc*2),0,c_white,1-rmtr_pc);
		}
	break;
	
	case tr_lerp_left:
		if (rmtr_steps == 1) {rmtr_data[0]=0;} else {rmtr_data[0] = lerp(rmtr_data[0],_trdw, 0.1 / max(rmtr_speed/60,0.001));}
		
		if !(surface_exists(rmtr_surface)) {
			rmtr_surface = surface_create(_trdw,_trdh);	
		}
		if !(surface_exists(rmtr_surface_2)) {
			rmtr_surface_2 = surface_create(_trdw,_trdh);	
		}
		if (rmtr_done<1) {
			surface_set_target(rmtr_surface);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
			room_goto(rmtr_room);
			rmtr_done = 1;
		} else {
			surface_set_target(rmtr_surface_2);
			draw_clear_alpha(c_black,0);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
		}
		draw_surface(rmtr_surface,0 - rmtr_data[0],0);
		draw_surface(rmtr_surface_2,_trdw - rmtr_data[0],0);
		
		if (room==rmtr_room && rmtr_data[0]==_trdw) {instance_destroy();}
	break;
	
	case tr_lerp_right:
		if (rmtr_steps == 1) {rmtr_data[0]=0;} else {rmtr_data[0] = lerp(rmtr_data[0],_trdw, 0.1 / max(rmtr_speed/60,0.001));}
		
		if !(surface_exists(rmtr_surface)) {
			rmtr_surface = surface_create(_trdw,_trdh);	
		}
		if !(surface_exists(rmtr_surface_2)) {
			rmtr_surface_2 = surface_create(_trdw,_trdh);	
		}
		if (rmtr_done<1) {
			surface_set_target(rmtr_surface);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
			room_goto(rmtr_room);
			rmtr_done = 1;
		} else {
			surface_set_target(rmtr_surface_2);
			draw_clear_alpha(c_black,0);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
		}
		draw_surface(rmtr_surface,rmtr_data[0],0);
		draw_surface(rmtr_surface_2,rmtr_data[0]-_trdw,0);
		
		if (room==rmtr_room && rmtr_data[0]==_trdw) {instance_destroy();}
	break;
	
	case tr_lerp_up:
		if (rmtr_steps == 1) {rmtr_data[0]=0;} else {rmtr_data[0] = lerp(rmtr_data[0],_trdh, 0.1 / max(rmtr_speed/60,0.001));}
		
		if !(surface_exists(rmtr_surface)) {
			rmtr_surface = surface_create(_trdw,_trdh);	
		}
		if !(surface_exists(rmtr_surface_2)) {
			rmtr_surface_2 = surface_create(_trdw,_trdh);	
		}
		if (rmtr_done<1) {
			surface_set_target(rmtr_surface);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
			room_goto(rmtr_room);
			rmtr_done = 1;
		} else {
			surface_set_target(rmtr_surface_2);
			draw_clear_alpha(c_black,0);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
		}
		draw_surface(rmtr_surface,0,0 - rmtr_data[0]);
		draw_surface(rmtr_surface_2,0,_trdh - rmtr_data[0]);
		
		if (room==rmtr_room && rmtr_data[0]==_trdh) {instance_destroy();}
	break;
	
	case tr_lerp_down:
		if (rmtr_steps == 1) {rmtr_data[0]=0;} else {rmtr_data[0] = lerp(rmtr_data[0],_trdh, 0.1 / max(rmtr_speed/60,0.001));}
		
		if !(surface_exists(rmtr_surface)) {
			rmtr_surface = surface_create(_trdw,_trdh);	
		}
		if !(surface_exists(rmtr_surface_2)) {
			rmtr_surface_2 = surface_create(_trdw,_trdh);	
		}
		if (rmtr_done<1) {
			surface_set_target(rmtr_surface);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
			room_goto(rmtr_room);
			rmtr_done = 1;
		} else {
			surface_set_target(rmtr_surface_2);
			draw_clear_alpha(c_black,0);
			draw_surface_stretched(application_surface,0,0,_trdw,_trdh);
			surface_reset_target();
		}
		draw_surface(rmtr_surface,0,rmtr_data[0]);
		draw_surface(rmtr_surface_2,0, rmtr_data[0]-_trdh);
		
		if (room==rmtr_room && rmtr_data[0]==_trdh) {instance_destroy();}
	break;
	
	
	
}

// Reset draw settings
draw_set_color(_tr_old_color);
draw_set_alpha(_tr_old_alpha);
gpu_set_tex_filter(_tr_old_interpolation);
