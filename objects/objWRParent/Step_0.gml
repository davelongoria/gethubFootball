/// @desc WR Step – facing & celebration final fix
if (global.game_paused) exit;

/* quit if QB missing */
if (!instance_exists(objQB)) exit;

/* ───── 1. CELEBRATION (run-in then pose) ───── */
if (celebrating)
{
    if (celebrate_buffer > 0)               // keep running to EZ centre
    {
        var dx = celebrate_target_x - x;
        move_x = sign(dx);  x += move_x * wr_speed;
        image_xscale = (move_x != 0) ? move_x : image_xscale;
        sprite_index = sprRunWithBallgry;
        celebrate_buffer--;
    }
    else                                    // pose
    {
        move_x = move_y = 0;
        sprite_index = sprCelebrateGry;
    }

    celebration_timer++;
    prev_x = x; prev_y = y;
    exit;                                   // Alarm 1 will clear flag
}

/* ───── 2. RETURN-TO-LOS (play dead) ───── */
if (!global.play_active)
{
    if (path_index != -1) { path_end(); path_started = false; route_finished = true; }
      //remove this if we want the rs to run back to scrimmage
		alarm[2]=20;
	  //
    var tx = objScrimmageMarker.x + start_offset_x;
    var ty = start_y;

    if (point_distance(x, y, tx, ty) <= wr_speed)
    {
        x = tx;  y = ty;  move_x = move_y = 0;
        assigned_path = "Path5";
        path_started = route_finished = false; path_pending = true;
        sprite_index  = sprIdlegry;
        image_xscale  = 1;                    // face RIGHT at snap
    }
    else
    {
        move_x = sign(tx - x);  move_y = sign(ty - y);
        image_xscale = (move_x != 0) ? move_x : image_xscale;
        x += move_x * wr_speed;  y += move_y * wr_speed;
        sprite_index = sprRunGry;
    }

    prev_x = x; prev_y = y;
    exit;
}

/* ───── 3. ACTIVE PLAY ───── */
if (id == global.player_has_ball)           // player-controlled
{
	
    if (path_index != -1) { path_end(); path_started = false; route_finished = true; }
    move_x = global.qb_move_x;  move_y = global.qb_move_y;
    if (abs(move_x) > 0.1) image_xscale = sign(move_x);
    x += move_x * wr_speed;  y += move_y * wr_speed;
}
else                                        // AI
{
    if (!route_finished)
    {
        if (path_pending)
        {
            if (assigned_path == "") assigned_path = "Path5";
            var p = asset_get_index(assigned_path);
            if (p != -1) { path_start(p, wr_speed, path_action_stop, false); path_started = true; }
            path_pending = false;
        }
        if (path_started && path_index == -1) { path_started = false; route_finished = true; }
    }
    else if (!hasBall)                      // drift to away EZ
    {
        move_x = 1; move_y = 0;  x += wr_speed;
        image_xscale = 1;
        if (object_exists(obj_endzone_away))
            if (instance_place(x, y, obj_endzone_away) != noone) move_x = 0;
    }
}

/* ───── 4. SPRITE based on velocity (also flips facing) ───── */
var dx = x - prev_x,  dy = y - prev_y;
if (abs(dx) > 0.3) image_xscale = sign(dx);      // face real motion

if (dy < -0.3 && abs(dx) < 0.3)      sprite_index = sprRunUpgry;
else if (dy > 0.3 && abs(dx) < 0.3)  sprite_index = sprRunDowngry;
else if (dy < -0.3 && abs(dx) > 0.3) sprite_index = sprRunUpRight;
else if (hasBall)                    sprite_index = sprRunWithBallgry;
else if (abs(dx) > 0.3 || abs(dy) > 0.3) sprite_index = sprRunGry;
else                                   sprite_index = sprIdlegry;

/* store for next frame */
prev_x = x; prev_y = y;
