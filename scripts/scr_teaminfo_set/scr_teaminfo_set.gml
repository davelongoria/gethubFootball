/// scr_teaminfo_set(team, name, city, abbr, logoFrame)
/// Stores/overwrites the info array for a team in global.team_info.

function scr_teaminfo_set(_team, _name, _city, _abbr, _logo_frame)
{
    if (!variable_global_exists("team_info"))
        global.team_info = ds_map_create();

    global.team_info[? _team] = [_name, _city, _abbr, _logo_frame];
}
