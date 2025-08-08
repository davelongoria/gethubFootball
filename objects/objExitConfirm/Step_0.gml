/// objExitConfirm – Step Event
//
// Handles YES / NO selection, plays sounds,
// commits roster edits on YES, and cleans up overlay state.
//

// ----------------------------------------
// 1. Navigate YES / NO  (← →  or  D-Pad)
// ----------------------------------------
if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_right) ||
    gamepad_button_check_pressed(0, gp_padl) || gamepad_button_check_pressed(0, gp_padr))
{
    selected_option = 1 - selected_option;          // toggle 0 ↔ 1
    if (audio_exists(sndSelect)) audio_play_sound(sndSelect,0,false);
}

// ----------------------------------------
// 2. Confirm selection (Enter / A button)
// ----------------------------------------
if (keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(0, gp_face1))
{
    if (selected_option == 0)
    {
        // ========  YES  –  Save & Exit  ========
        if (instance_exists(objTeamRosterEditor))
        {
            // Commit grid_data + team info back to TEMPLATE
            //   (rename the script call below if you used the shorter name)
            scr_commit_roster_edits();
        }

        // Reset global overlay flags & destroy roster editor/dimmer
        scr_reset_roster_editor_state();
    }
    else
    {
        // ========  NO  –  Exit WITHOUT Saving ========
        scr_reset_roster_editor_state();
    }

    // Destroy this confirmation popup
    instance_destroy();
}
