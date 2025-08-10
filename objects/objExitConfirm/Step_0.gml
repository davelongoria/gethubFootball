/// @desc objExitConfirm – Step Event

// YES / NO detection
var yes_pressed = keyboard_check_pressed(ord("Y")) || gamepad_button_check_pressed(0, gp_face1); // A button
var no_pressed  = keyboard_check_pressed(ord("N")) || gamepad_button_check_pressed(0, gp_face2); // B button

if (yes_pressed) {
    if (save_before_exit) {
        if (script_exists(scr_commit_roster_edits_to_template)) {
            scr_commit_roster_edits_to_template();
        }
        if (script_exists(scr_save_team_data)) {
            scr_save_team_data();
        }
        global.roster_dirty = false;
    }
    // Close editor
    if (instance_exists(objTeamRosterEditor)) instance_destroy(objTeamRosterEditor);
    if (instance_exists(objModalDimmer)) instance_destroy(objModalDimmer);
    instance_destroy(id);
}

if (no_pressed) {
    // Close without saving
    if (instance_exists(objTeamRosterEditor)) instance_destroy(objTeamRosterEditor);
    if (instance_exists(objModalDimmer)) instance_destroy(objModalDimmer);
    instance_destroy(id);
}
