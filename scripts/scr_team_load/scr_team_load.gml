/// scr_team_load(fname)
/// Loads one JSON file, registers its palette and info, adds to global.teams.
function scr_team_load(fname)
{
    // Ensure global.teams exists
    if (!variable_global_exists("teams") || !ds_exists(global.teams, ds_type_map))
        global.teams = ds_map_create();

    // Read file into string
    var fh  = file_text_open_read(fname);
    var raw = file_text_read_string(fh);
    file_text_close(fh);

    // Parse JSON (catch errors so bad files don't crash startup)
    var data;
    try { data = json_parse(raw); } catch (e) {
        show_debug_message("scr_team_load – JSON error in " + fname);
        return;
    }
    if (data == undefined) return;

    // Determine team name
    var tname = string(data.team_name);

    // Add/replace in global.teams
    ds_map_replace(global.teams, tname, data);

    // Register palette
    if (!variable_global_exists("team_palettes"))
        global.team_palettes = ds_map_create();
    var pal_copy = array_create(array_length(data.colours), 0);
    array_copy(pal_copy, 0, data.colours, 0, array_length(data.colours));
    global.team_palettes[? tname] = pal_copy;

    // Register info (name, city, abbr, logo)
    if (!variable_global_exists("team_info"))
        global.team_info = ds_map_create();
    var city = variable_struct_exists(data, "city") ? data.city : "";
    var abbr = variable_struct_exists(data, "abbr") ? data.abbr : "";
    var logo = variable_struct_exists(data, "logo") ? data.logo : 0;
    global.team_info[? tname] = [tname, city, abbr, logo];

    show_debug_message("scr_team_load – loaded \"" + tname + "\"");
}
