/// @description Insert description here
// You can write your code in this editor
/// @desc objDebugger Step Event — Game State Logger

// === General Game State ===
show_debug_message("================== GAME STATE ==================");
show_debug_message("global.play_active: " + string(global.play_active));
show_debug_message("global.qb_hike: " + string(global.qb_hike));
show_debug_message("global.throw_pressed: " + string(global.throw_pressed));
show_debug_message("global.qb_move_x: " + string(global.qb_move_x) + " | global.qb_move_y: " + string(global.qb_move_y));
show_debug_message("global.touchdown_scored: " + string(global.touchdown_scored));
show_debug_message("global.player_has_ball: " + string(global.player_has_ball));
show_debug_message("global.score_home: " + string(global.score_home) + " | global.score_away: " + string(global.score_away));

// === QB Status ===
if (instance_exists(objQB)) {
    with (objQB) {
        show_debug_message("--- QB ---");
        show_debug_message("x: " + string(x) + " | y: " + string(y));
        show_debug_message("hiked: " + string(hiked));
        show_debug_message("can_throw: " + string(can_throw));
        show_debug_message("ballHiked: " + string(ballHiked));
        show_debug_message("attached_to == id: " + string(attached_to == id));
        show_debug_message("sprite: " + string(sprite_index));
    }
} else {
    show_debug_message("No QB instance found");
}
// In objDebugger Step Event
if (instance_exists(objQB)) {
    show_debug_message("QB STEP TICK");
    show_debug_message("hiked: " + string(objQB.hiked) + 
        " | can_throw: " + string(objQB.can_throw) + 
        " | attached_to == QB: " + string(objFootball.attached_to == objQB.id));
    show_debug_message("global.qb_hike: " + string(global.qb_hike) + 
        " | global.throw_pressed: " + string(global.throw_pressed));
    show_debug_message("global.qb_move_x: " + string(global.qb_move_x) + 
        " | global.qb_move_y: " + string(global.qb_move_y));
}

// === Football Status ===
if (instance_exists(objFootball)) {
    with (objFootball) {
        show_debug_message("--- Football ---");
        show_debug_message("x: " + string(x) + " | y: " + string(y));
        show_debug_message("visible: " + string(visible));
        show_debug_message("attached_to: " + string(attached_to));
        show_debug_message("play_active: " + string(global.play_active));
        show_debug_message("speed: " + string(speed) + " | direction: " + string(direction));
    }
} else {
    show_debug_message("No Football instance found");
}

// === WRs Status ===
var wr_objs = [objWR1, objWR2, objWR3, objWR4, objWR5];
for (var i = 0; i < array_length(wr_objs); i++) {
    var wr = instance_exists(wr_objs[i]) ? instance_nearest(x, y, wr_objs[i]) : noone;
    if (wr != noone) {
        with (wr) {
            show_debug_message("--- WR" + string(i + 1) + " ---");
            show_debug_message("x: " + string(x) + " | y: " + string(y));
            show_debug_message("hasBall: " + string(hasBall));
            show_debug_message("caught: " + string(caught));
            show_debug_message("jumping: " + string(jumping));
            show_debug_message("returning: " + string(returning));
            show_debug_message("sprite: " + string(sprite_index));
        }
    }
}

// === Scrimmage Marker ===
if (instance_exists(objScrimmageMarker)) {
    with (objScrimmageMarker) {
        show_debug_message("--- Scrimmage Marker ---");
        show_debug_message("x: " + string(x) + " | y: " + string(y));
    }
}
