// --- objTeamSelectController: Create Event ---

hovered      = -1;
hovered_btn  = -1;
selected     = 0; // current highlighted button index
edit_team_index = 0;

// --- Menu Buttons ---
menu_buttons = ["Quick Play", "Edit Team", "Create Team", "Franchise", "Online Play", "Settings", "Exit"];
teams = [];

// --- Load created teams from global.team_palettes (ds_map) ---
if (variable_global_exists("team_palettes")) {
    var _pal = global.team_palettes;
    if (!is_undefined(_pal)) {
        var _key = ds_map_find_first(_pal);
        while (!is_undefined(_key)) {
            array_push(teams, _key);
            _key = ds_map_find_next(_pal, _key);
        }
        show_debug_message("[TEAM SELECT] Loaded teams from global.team_palettes: " + string(teams));
    } else {
        show_debug_message("[TEAM SELECT] global.team_palettes is undefined.");
    }
}

// Fallback if teams is empty (no palette map loaded)
if (array_length(teams) == 0) {
    teams = ["Cowboys", "Raiders", "Packers", "Bears", "Vikings"];
    show_debug_message("[TEAM SELECT] Using fallback default teams.");
}

// --- Input Debounce (Gamepad) ---
last_gp_up = false;
last_gp_down = false;
last_gp_left = false;
last_gp_right = false;
last_gp_a = false;
last_gp_b = false;
last_gp_axis_y = 0;
last_gp_axis_x = 0;
