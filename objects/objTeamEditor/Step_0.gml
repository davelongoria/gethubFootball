/// objTeamEditor – Step Event
//
// Opens the roster editor overlay on Start / Enter.
// Re–uses any edits stored in global.roster_editor_data.
//

// ------------------------------------------------------------------
// 0. Ensure overlay flags exist
// ------------------------------------------------------------------
if (!variable_global_exists("roster_editor_active")) global.roster_editor_active = false;
if (!variable_global_exists("ui_overlay_active"))    global.ui_overlay_active    = false;
if (!variable_global_exists("coming_soon_active"))  global.coming_soon_active  = false;

// ------------------------------------------------------------------
// 1. Listen for Start (controller) or Enter (keyboard)
// ------------------------------------------------------------------
var start_pressed = keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(0, gp_start);

if (start_pressed && !global.roster_editor_active && !global.ui_overlay_active && !global.coming_soon_active)
{
    //---------------------------------------------------------------
    // 1a. Mark overlay active
    //---------------------------------------------------------------
    global.roster_editor_active = true;

    //---------------------------------------------------------------
    // 1b. Ensure global.roster_editor_data has current copy
    //---------------------------------------------------------------
    if (!variable_global_exists("roster_editor_data") || array_length_1d(global.roster_editor_data) == 0)
    {
        if (variable_global_exists("teams") && ds_map_exists(global.teams, "TEMPLATE"))
        {
            var tmpl = global.teams[? "TEMPLATE"];

            if (is_struct(tmpl) && variable_struct_exists(tmpl, "roster"))
            {
                // ★ Manual deep-clone (no array_clone in older runtimes)
                var len = array_length(tmpl.roster);
                global.roster_editor_data = array_create(len, 0);
                array_copy(global.roster_editor_data, 0, tmpl.roster, 0, len);  // ★

                show_debug_message("=== LOADING TEMPLATE ROSTER INTO EDITOR ===");
                for (var i = 0; i < len; i++)
                    show_debug_message("[" + string(i) + "] " + global.roster_editor_data[i].name);
            }

            if (variable_struct_exists(tmpl, "team_name")) team_name  = tmpl.team_name;
            if (variable_struct_exists(tmpl, "city"))      team_city  = tmpl.city;
            if (variable_struct_exists(tmpl, "team_abbr")) team_abbr  = tmpl.team_abbr;
        }
    }
    else
    {
        show_debug_message("=== RE-OPENING ROSTER WITH PRIOR SESSION EDITS ===");
    }

    //---------------------------------------------------------------
    // 1c. Spawn overlay objects
    //---------------------------------------------------------------
    if (!instance_exists(objModalDimmer))
        instance_create_layer(0, 0, "GUI", objModalDimmer);

    if (!instance_exists(objTeamRosterEditor))
        instance_create_layer(0, 0, "GUI", objTeamRosterEditor);
}
