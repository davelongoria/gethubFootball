if (variable_global_exists("team_edit_name") && !variable_global_exists("team_to_edit"))
    global.team_to_edit = global.team_edit_name;

// --- Palette / Swatch Loading ---
global.selected_sw = -1;          // no swatch highlighted yet

/// 1. Which team are we editing?
var teamname = (variable_global_exists("team_to_edit"))
             ? global.team_to_edit
             : "Default";

/// 2. Load that team’s palette (deep-copy so we can cancel later)
var src_palette;

if (ds_map_exists(global.team_palettes, teamname)) {
    src_palette = global.team_palettes[? teamname];

    // if saved as comma-string in text file → convert back to array of numbers
    if (is_string(src_palette)) {
        var parts = string_split(src_palette, ",");
        for (var i = 0; i < array_length(parts); ++i) parts[i] = real(parts[i]);
        src_palette = parts;
    }
}
else {
    src_palette = global.team_palettes[? "Default"];
}

/// make a working copy for the editor
global.current_pal = array_create(array_length(src_palette), 0);
array_copy(global.current_pal, 0, src_palette, 0, array_length(src_palette));
global.current_team = teamname;

/// 3. *Now* rebuild the 1×N palette surface for the shader / swatches
scr_palette_surface_refresh();
