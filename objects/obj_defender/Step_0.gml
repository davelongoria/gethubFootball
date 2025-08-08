// obj_defender Step Event

// 1. PRE-SNAP: Stand idle and do nothing before the play is live.
if (!global.qb_hike) {
    speed = 0;
    if (sprite_index != spr_idle) sprite_index = spr_idle;
    is_grappling = false;
    exit;
}

// 2. DURING PLAY: Target the ballcarrier
if (global.player_has_ball != noone && instance_exists(global.player_has_ball)) {
    var ballcarrier = global.player_has_ball;

    // Attempt to move toward the ballcarrier
    var old_x = x;
    var old_y = y;
    scr_defender_move_towards(ballcarrier.x, ballcarrier.y, speed);

    // Debug: Did we actually move?
    if (x == old_x && y == old_y) {
        show_debug_message("Defender " + string(id) + " did NOT move (blocked or at target).");
    } else {
        show_debug_message("Defender " + string(id) + " moved to (" + string(x) + "," + string(y) + ")");
    }
    show_debug_message("Ballcarrier (global.player_has_ball): " + string(ballcarrier));

    // Set running sprite unless tackling
    if (state != "tackle" && sprite_index != spr_run) sprite_index = spr_run;

    // TACKLE if close enough
    if (point_distance(x, y, ballcarrier.x, ballcarrier.y) < 16) {
        state = "tackle";
        if (sprite_index != spr_grapple) sprite_index = spr_grapple;
        // Stop ballcarrier if possible
        if (variable_instance_exists(ballcarrier, "speed")) {
            ballcarrier.speed = 0;
        }
    }
} else {
    // No ballcarrier found (dead ball, incomplete, or play reset)
    if (sprite_index != spr_idle) sprite_index = spr_idle;
}
