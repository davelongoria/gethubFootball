// Mouse Left Pressed event for objSaveButton

// 1. Get the current team name
var team_name = global.team_to_edit;

// 2. Create a copy of the palette
var pal_copy = array_create(array_length(global.current_pal));
for (var i = 0; i < array_length(global.current_pal); ++i) {
    pal_copy[i] = global.current_pal[i];
}

// 3. Store in global.team_palettes
if (variable_global_exists("team_palettes")) {
    global.team_palettes[? team_name] = pal_copy;
    show_debug_message("Saved palette for team: " + string(team_name));
}

// 4. [Optional] Save all palettes to a file for persistence
var save_str = "";
var keys = scr_safe_ds_map_keys(global.team_palettes);
for (var k = 0; k < array_length(keys); ++k) {
    var key = keys[k];
    var pal = global.team_palettes[? key];
    save_str += key + ":";
    for (var i = 0; i < array_length(pal); ++i) {
        save_str += string(pal[i]);
        if (i < array_length(pal) - 1) save_str += ",";
    }
    save_str += "\n";
}
// You can use the same file_name logic or a more general location:
var file_name = "C:\\Users\\" + environment_get_variable("USERNAME") + "\\AppData\\Local\\Pixel_Bowl\\palettes.txt";
var file = file_text_open_write(file_name);
file_text_write_string(file, save_str);
file_text_close(file);

show_debug_message("Saved all palettes to: " + file_name);
