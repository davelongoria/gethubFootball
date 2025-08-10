/// scr_roster_apply_grid_to_models(teamname, grid_data, team_name, team_city, team_abbr)
var _teamname = argument0;
var _grid     = argument1;
var _tname    = argument2;
var _tcity    = argument3;
var _tabbr    = argument4;

// --- ensure the team_info map exists ---
if (!variable_global_exists("team_info") || !ds_exists(global.team_info, ds_type_map)) {
    global.team_info = ds_map_create();
}

// --- team header back into global.team_info ---
if (!ds_map_exists(global.team_info, _teamname)) {
    global.team_info[? _teamname] = ["", "", "", 0];
}
var info_arr = global.team_info[? _teamname];
if (!is_array(info_arr) || array_length(info_arr) < 4) {
    var patched = array_create(4,0);
    if (is_array(info_arr) && array_length(info_arr) > 0) patched[0] = info_arr[0];
    if (is_array(info_arr) && array_length(info_arr) > 1) patched[1] = info_arr[1];
    if (is_array(info_arr) && array_length(info_arr) > 2) patched[2] = info_arr[2];
    info_arr = patched;
}
info_arr[0] = _tname;
info_arr[1] = _tcity;
info_arr[2] = _tabbr;
global.team_info[? _teamname] = info_arr;

// --- player rows back into global.roster_editor_data ---
for (var i = 0; i < array_length(_grid); i++) {
    var row = _grid[i];
    if (is_struct(row) && row.type == "player") {
        var idx = row.index;
        if (idx >= 0 && idx < array_length(global.roster_editor_data)) {
            var p = global.roster_editor_data[idx];
            if (!is_struct(p)) p = {};
            // fields: [name, pos, speed, agility, tackle, durability]
            var f = row.fields;
            p.name       = f[0];
            p.pos        = f[1];
            p.speed      = real(f[2]);
            p.agility    = real(f[3]);
            p.tackle     = real(f[4]);
            p.durability = real(f[5]);
            // NOTE: portraits are edited live in the editor; we leave p.portrait untouched
            global.roster_editor_data[idx] = p;
        }
    }
}
