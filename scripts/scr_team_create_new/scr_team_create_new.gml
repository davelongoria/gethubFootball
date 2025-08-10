/// scr_team_create_new(name, city, abbr, palette_key)
/// Returns a fully-formed team struct and persists it.
function scr_team_create_new(_name, _city, _abbr, _pal_key)
{
    // palette: use existing map (falls back to Default)
    if (!variable_global_exists("team_palettes")) scr_palette_init("Default");
    var pal = ds_map_exists(global.team_palettes, _pal_key)
            ? global.team_palettes[? _pal_key]
            : global.team_palettes[? "Default"];

    var team = {
        team_name : string(_name),
        city      : string(_city),
        team_abbr : string(_abbr),
        logo      : 0,
        colours   : pal,
        roster    : scr_make_random_roster(53) // 53-man
    };

    // Register in memory
    if (!variable_global_exists("teams")) global.teams = ds_map_create();
    ds_map_replace(global.teams, team.team_name, team);

    // Persist immediately
    scr_team_save(team);

    // Rebuild menus/list if needed
    scr_team_load_all();

    return team;
}
