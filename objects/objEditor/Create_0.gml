// --- objEditor Create Event ---

// 1. Ensure data structures exist
if (!variable_global_exists("team_palettes")) {
    global.team_palettes = ds_map_create();
}
if (!variable_global_exists("team_info")) {
    global.team_info = ds_map_create();
}

// 2. Team name to edit (or "Default" fallback)
var teamname = (variable_global_exists("team_to_edit")) ? global.team_to_edit : "Default";

// 3. Load or fallback the team palette
if (ds_map_exists(global.team_palettes, teamname)) {
    var src_palette = global.team_palettes[? teamname];
    if (is_string(src_palette)) {
        src_palette = string_split(src_palette, ",");
        for (var i = 0; i < array_length(src_palette); ++i) {
            src_palette[i] = real(src_palette[i]);
        }
    }
    // Deep copy so edits don't affect original until Save
    global.current_pal = array_create(array_length(src_palette), 0);
    array_copy(global.current_pal, 0, src_palette, 0, array_length(src_palette));
    global.current_team = teamname;
} else {
    // Fallback to default palette
    var def_palette = global.team_palettes[? "Default"];
    global.current_pal = array_create(array_length(def_palette), 0);
    array_copy(global.current_pal, 0, def_palette, 0, array_length(def_palette));
    global.current_team = "Default";
}

// 4. Palette surface and state
scr_palette_surface_refresh();
global.selected_sw = -1;

// 5. Load (or initialise) the info fields + logo frame
if (!variable_global_exists("team_info"))
    global.team_info = ds_map_create();

var info_arr;
if (ds_map_exists(global.team_info, teamname))
    info_arr = global.team_info[? teamname];
else    // first-time team → blank fields
{
    info_arr = ["", "", "", 0];        // [name, city, abbr, logoFrame]
    global.team_info[? teamname] = info_arr;
}

team_name  = (string_length(info_arr[0]) > 0) ? info_arr[0] : teamname;
team_city  = info_arr[1];
team_abbr  = info_arr[2];
logo_frame = info_arr[3];              // sprite frame or custom index


// 6. Editor UI state
active_field = 0;
max_length = [24, 24, 4];
offset_y = [0, 60, 120];
field_labels = ["TEAM NAME", "CITY", "ABBR"];
box_x = 0;
box_w = 340;
box_h = 38;
keyboard_string = "";
