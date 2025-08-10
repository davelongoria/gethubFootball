/// scr_team_load(fname)
/// Loads one JSON file, normalizes portraits & palette, registers team in globals.
function scr_team_load(fname)
{
    // Ensure global.teams exists
    if (!variable_global_exists("teams") || !ds_exists(global.teams, ds_type_map))
        global.teams = ds_map_create();

    // Read file into string
    if (!file_exists(fname)) {
        show_debug_message("scr_team_load – file not found: " + string(fname));
        return;
    }
    var fh  = file_text_open_read(fname);
    var raw = file_text_read_string(fh);
    file_text_close(fh);

    // Parse JSON (catch errors so bad files don't crash startup)
    var data;
    try { data = json_parse(raw); } catch (e) {
        show_debug_message("scr_team_load – JSON error in " + string(fname));
        return;
    }
    if (!is_struct(data)) return;

    // --- Ensure portrait palettes exist (safe if already set)
    if (!variable_global_exists("PAL_SKIN"))  scr_portrait_palettes_init();

    // --- Normalize roster: guarantee portraits on each player
    if (variable_struct_exists(data, "roster") && is_array(data.roster)) {
        for (var i = 0; i < array_length(data.roster); i++) {
            var p = data.roster[i];
            if (is_struct(p)) {
                if (!variable_struct_exists(p, "portrait") || is_undefined(p.portrait)) {
                    p.portrait = scr_portrait_random();
                } else {
                    p.portrait = scr_portrait_ensure(p.portrait);
                }
                data.roster[i] = p;
            }
        }
    }

    // --- Determine team name
    var tname = variable_struct_exists(data, "team_name") ? string(data.team_name) : "Unnamed";

    // --- Ensure colours exist (fallback to Default)
if (!variable_struct_exists(data, "colours") || !is_array(data.colours) || array_length(data.colours) == 0) {
    // Make sure palette map exists; scr_palette_init builds it if missing
    if (!variable_global_exists("team_palettes")) {
        scr_palette_init("Default");
    }
    data.colours = ds_map_exists(global.team_palettes,"Default")
                 ? global.team_palettes[? "Default"]
                 : [ $FFFFFF ]; // ultra-safe 1 color fallback
}

    // --- Add/replace team in global.teams
    ds_map_replace(global.teams, tname, data);

    // --- Register team palette
    if (!variable_global_exists("team_palettes"))
        global.team_palettes = ds_map_create();

    var pal_copy = array_create(array_length(data.colours), 0);
    array_copy(pal_copy, 0, data.colours, 0, array_length(data.colours));
    global.team_palettes[? tname] = pal_copy;

    // --- Register info (name, city, abbr, logo)
    if (!variable_global_exists("team_info"))
        global.team_info = ds_map_create();

    var city = variable_struct_exists(data, "city") ? string(data.city) : "";
    var abbr = variable_struct_exists(data, "team_abbr") ? string(data.team_abbr) 
             : (variable_struct_exists(data, "abbr") ? string(data.abbr) : "");
    var logo = variable_struct_exists(data, "logo") ? real(data.logo) : 0;

    global.team_info[? tname] = [tname, city, abbr, logo];

    show_debug_message("scr_team_load – loaded \"" + tname + "\"");
}
