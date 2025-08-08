if (global.game_paused) exit;
if (!instance_exists(objQB)) exit;

// --- INIT for robust path logic (set these in Create if not present) ---
if (!variable_instance_exists(self, "route_started"))   route_started = false;
if (!variable_instance_exists(self, "route_cooldown"))  route_cooldown = 0;
if (!variable_instance_exists(self, "hasBall"))         hasBall = false;
if (!variable_instance_exists(self, "ran_path5"))       ran_path5 = false;
if (!variable_instance_exists(self, "waiting_for_path5")) waiting_for_path5 = false;

// --- 1. DELAYED PATH LOGIC: After hike on pass plays, wait, then run Path6, then Path5 ---
if (objQB.hiked && !global.play_is_run && !route_started && !hasBall)
{
    route_cooldown = 100; // Number of steps to wait after hike
    route_started = true;
    ran_path5 = false;
    waiting_for_path5 = false;
}

// Handle route delay, then fire alarm[0] to start path6
if (route_cooldown > 0 && !hasBall)
{
    route_cooldown--;
    if (route_cooldown == 0)
        alarm[0] = 1; // Path6 starts in Alarm[0]
}

// When finished Path6, set alarm[1] for Path5 (never loops)
if (
    path_index == -1 &&
    route_started && 
    !hasBall && 
    route_cooldown == 0 && 
    !celebrating && 
    global.play_active &&
    !waiting_for_path5 && 
    !ran_path5 // Make sure Path5 not started already
) {
    alarm[1] = 60; // Wait 60 steps, then Path5 in Alarm[1]
    waiting_for_path5 = true;
}

// Reset all route/path logic after play ends (for next play)
if (!global.play_active && (route_started || route_cooldown > 0))
{
    route_started = false;
    route_cooldown = 0;
    ran_path5 = false;
    waiting_for_path5 = false;
}

// --- 2. CELEBRATION ---
if (celebrating)
{
    if (celebrate_buffer > 0)
    {
        var dx = celebrate_target_x - x;
        var move_x = sign(dx);  x += move_x * rb_speed;
        image_xscale = (move_x != 0) ? move_x : image_xscale;
        sprite_index = spr_run_with_ball;
        celebrate_buffer--;
    }
    else
    {
        sprite_index = spr_celebrate;
    }
    prev_x = x; prev_y = y;
    exit;
}

// --- 3. RETURN TO LOS ---
if (!global.play_active)
{
    if (path_index != -1) path_end(); // End any paths on dead play

    var tx = objScrimmageMarker.x + start_offset_x;
    var ty = start_y;
    if (point_distance(x, y, tx, ty) <= rb_speed)
    {
        x = tx; y = ty;
        sprite_index = spr_idle;
        image_xscale = 1;
    }
    else
    {
        var move_x = sign(tx - x);  var move_y = sign(ty - y);
        image_xscale = (move_x != 0) ? move_x : image_xscale;
        x += move_x * rb_speed; y += move_y * rb_speed;
        sprite_index = spr_run;
    }
    prev_x = x; prev_y = y;
    exit;
}

// --- 4. ACTIVE PLAY: player control if has ball, AI otherwise ---
if (id == global.player_has_ball)
{
    hasBall = true;
    if (path_index != -1) path_end(); // Stop any paths on catch

    var move_x = global.qb_move_x; var move_y = global.qb_move_y;
    if (abs(move_x) > 0.1) image_xscale = sign(move_x);
    x += move_x * rb_speed; y += move_y * rb_speed;
}
else
{
    hasBall = false;
    // AI/pathing handled by alarms and path logic above
}

// --- 5. SPRITE SELECTION ---
var dx = x - prev_x,  dy = y - prev_y;
if (abs(dx) > 0.3) image_xscale = sign(dx);

if (dy < -0.3 && abs(dx) < 0.3)      sprite_index = spr_run_up;
else if (dy > 0.3 && abs(dx) < 0.3)  sprite_index = spr_run_down;
else if (dy < -0.3 && abs(dx) > 0.3) sprite_index = spr_run_upright;
else if (hasBall)                    sprite_index = spr_run_with_ball;
else if (abs(dx) > 0.3 || abs(dy) > 0.3) sprite_index = spr_run;
else                                   sprite_index = spr_idle;

prev_x = x; prev_y = y;
