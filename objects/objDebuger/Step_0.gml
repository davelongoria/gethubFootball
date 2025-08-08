debugStuff = "===== GAME STATE =====\n";
debugStuff += "global.qb_hike: " + string(global.qb_hike) + "\n";
debugStuff += "global.play_active: " + string(global.play_active) + "\n";
debugStuff += "global.player_has_ball: " + string(global.player_has_ball) + " (exists: " + string(instance_exists(global.player_has_ball)) + ")\n";
debugStuff += "global.qb_move_x: " + string(global.qb_move_x) + " | global.qb_move_y: " + string(global.qb_move_y) + "\n";
debugStuff += "global.touchdown_scored: " + string(global.touchdown_scored) + "\n";
debugStuff += "global.score_home: " + string(global.score_home) + " | global.score_away: " + string(global.score_away) + "\n";

if (instance_exists(objQB)) {
    debugStuff += "--- QB ---\n";
    debugStuff += "x: " + string(objQB.x) + " | y: " + string(objQB.y) + "\n";
    debugStuff += "hiked: " + string(objQB.hiked) + "\n";
    debugStuff += "can_throw: " + string(objQB.can_throw) + "\n";
    debugStuff += "attached_to == QB: " + string(objFootball.attached_to == objQB.id) + "\n";
}

if (instance_exists(objFootball)) {
    debugStuff += "--- Football ---\n";
    debugStuff += "x: " + string(objFootball.x) + " | y: " + string(objFootball.y) + "\n";
    debugStuff += "attached_to: " + string(objFootball.attached_to) + "\n";
    debugStuff += "visible: " + string(objFootball.visible) + "\n";
}

// Collect info from all defenders
var defenders_info = "";
with (obj_defender) {
    defenders_info += "--- Defender " + string(id) + " ---\n";
    defenders_info += "x: " + string(x) + " | y: " + string(y) + "\n";
    defenders_info += "state: " + string(state) + " | sprite: " + string(sprite_index) + "\n";
}
debugStuff += defenders_info;

// Collect info from all WRs
var wr_info = "";
with (objWRParent) {
    wr_info += "--- WR id: " + string(id) + " ---\n";
    wr_info += "x: " + string(x) + " | y: " + string(y) + "\n";
    wr_info += "hasBall: " + string(hasBall) + "\n";
    wr_info += "caught: " + string(caught) + "\n";
    wr_info += "returning: " + string(returning) + "\n";
    wr_info += "sprite: " + string(sprite_index) + "\n";
}
debugStuff += wr_info;

// Scrimmage marker info
if (instance_exists(objScrimmageMarker)) {
    debugStuff += "--- Scrimmage Marker ---\n";
    debugStuff += "x: " + string(objScrimmageMarker.x) + " | y: " + string(objScrimmageMarker.y) + "\n";
}

debugStuff += "========================\n";
show_debug_message(debugStuff);
