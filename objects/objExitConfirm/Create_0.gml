/// objExitConfirm - Create Event
depth = -10002;
/// objExitConfirm - Create Event

selected_option = 0; // 0 = Yes, 1 = No
question_text = "Would you like to save before exiting?";

// Disable input lock if called from Coming Soon popup
if (!variable_global_exists("exit_confirm_active")) {
    global.exit_confirm_active = true;
}