// obj_offensive_lineman Step Event

if (!global.qb_hike) {
    speed = 0;
    if (sprite_index != spr_idle) sprite_index = spr_idle;
    is_grappling = false;
    exit;
}

// Find nearest defender in front
if (!is_grappling) {
    var nearest_defender = instance_nearest(x, y, obj_defender);
    if (instance_exists(nearest_defender) && point_distance(x, y, nearest_defender.x, nearest_defender.y) < 32) {
        // Start grapple
        is_grappling = true;
        grapple_timer = room_speed * irandom_range(1, 2);
        grapple_target = nearest_defender.id;
        sprite_index = spr_grapple;
        // Force defender into grapple too
        with (nearest_defender) {
            is_grappling = true;
            grapple_timer = other.grapple_timer;
            grapple_target = other.id;
            sprite_index = spr_grapple;
            state = "grapple";
        }
    } else {
        // No defender to block: go to run/idle
        if (sprite_index != spr_run) sprite_index = spr_run;
        // Optional: Move slightly forward, or stand ground
        //x += 0.3; // Comment out if you don't want O-line to creep forward
    }
} else if (is_grappling && instance_exists(grapple_target)) {
    // Engage grapple: hold position, maybe jitter slightly for animation
    grapple_timer--;
    // (Optional: jitter effect)
    x += lengthdir_x(1, random(360));
    y += lengthdir_y(1, random(360));
    if (grapple_timer <= 0) {
        // Grapple ends: randomly decide who wins
        var outcome = choose("win", "lose");
        is_grappling = false;
        if (outcome == "win") {
            sprite_index = spr_idle; // O-lineman holds
            with (instance_find(grapple_target, 0)) {
                is_grappling = false;
                state = "normal";
                sprite_index = spr_idle;
            }
        } else {
            // Lineman is pancaked
            pancaked = true;
            pancake_timer = room_speed * 2;
            sprite_index = spr_pancaked;
            with (instance_find(grapple_target, 0)) {
                is_grappling = false;
                state = "break_free";
                sprite_index = spr_run;
            }
        }
    }
} else if (pancaked) {
    pancake_timer--;
    if (sprite_index != spr_pancaked) sprite_index = spr_pancaked;
    if (pancake_timer <= 0) {
        pancaked = false;
        sprite_index = spr_idle;
    }
} else {
    // No block or grapple, just idle
    if (sprite_index != spr_idle) sprite_index = spr_idle;
}
