/// objTeamController – Create  (runtime-safe)
// objTeamController – Create (add these lines)
cpu_pick_mode = false;   // false = normal, true = choosing CPU team

prev_ax  = 0;
prev_ay  = 0;
prev_ax1 = 0;
prev_ay1 = 0;


//----------------------------------------------------
// 1.  Make sure we have a DS-map-keys helper
//----------------------------------------------------
var _scr_idx = asset_get_index("scr_safe_ds_map_keys");   // −1 if missing
if (_scr_idx != -1 && script_exists(_scr_idx))
{
    // real script asset exists – store a reference
    global.scr_safe_ds_map_keys = scr_safe_ds_map_keys;
}
else
{
    /// fallback – single-file version
    global.scr_safe_ds_map_keys = function (_map)
    {
        if (is_undefined(_map) || !ds_exists(_map, ds_type_map)) return [];
        var _out = [];
        var _k   = ds_map_find_first(_map);
        while (!is_undefined(_k))
        {
            array_push(_out, _k);
            _k = ds_map_find_next(_map, _k);
        }
        return _out;
    };
}

//----------------------------------------------------
// 2.  Build the sorted team list (skip “Default”)
//----------------------------------------------------
var map_keys = global.scr_safe_ds_map_keys(global.team_palettes);

teams = [];
for (var i = 0; i < array_length(map_keys); ++i)
{
    if (map_keys[i] != "Default")
        array_push(teams, map_keys[i]);
}

// 2-argument form:  true = ascending
array_sort(teams, true);                       

if (array_length(teams) < 2) array_push(teams, teams[0]); // safety

home_index = 0;
away_index = 1;
team_ct    = array_length(teams);                          // for wrap helpers

//----------------------------------------------------
// 3.  Layout & marker instances
//----------------------------------------------------
xs    = [300, 920];
y_row = 360;

p1        = instance_create_layer(xs[0], y_row, "GUI", objP1);
cpu_or_p2 = instance_create_layer(xs[1], y_row, "GUI", objCPU);

p1.side        = 0;
cpu_or_p2.side = 1;

//----------------------------------------------------
// 4.  Stick history & P-2 state
//----------------------------------------------------
//----------------------------------------------------
// 4.  Stick history & P-2 state
//----------------------------------------------------
prev_ax  = 0;
prev_ay  = 0;
prev_ax1 = 0;
prev_ay1 = 0;

p2_is_human    = false;
p2_idle_ctr    = 0;
cpu_idle_steps = 400;


p2_is_human    = false;
p2_idle_ctr    = 0;
cpu_idle_steps = 400;

//----------------------------------------------------
// 5.  Optional sound flags
//----------------------------------------------------
have_sndSelect = (asset_get_index("sndSelect")  != -1);
have_sndPress  = (asset_get_index("sndPressed") != -1);
