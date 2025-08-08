/// scr_reset_roster_editor_state

/// This is a SCRIPT to reset all roster editor UI objects and states.

// Destroy UI Objects if they exist
if (instance_exists(objModalDimmer)) with (objModalDimmer) instance_destroy();
if (instance_exists(objTeamRosterEditor)) with (objTeamRosterEditor) instance_destroy();
if (instance_exists(objVirtualKeyboard)) with (objVirtualKeyboard) instance_destroy();
if (instance_exists(objComingSoonPopup)) with (objComingSoonPopup) instance_destroy();
if (instance_exists(objExitConfirm)) with (objExitConfirm) instance_destroy();

// Reset global flags
global.roster_editor_active = false;
global.ui_overlay_active = false;
global.coming_soon_active = false;
