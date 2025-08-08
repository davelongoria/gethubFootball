/// scr_array_delete_value(arr, val)  → returns trimmed copy
function scr_array_delete_value(arr, val)
{
    var out = [];
    for (var i = 0; i < array_length(arr); ++i)
        if (arr[i] != val) array_push(out, arr[i]);
    return out;
}

/// scr_safe_ds_map_keys(dsmap) → array of keys  (empty if ds is bad)
function scr_safe_ds_map_keys(dsmap)
{
    if (!ds_exists(dsmap, ds_type_map)) return [];
    var keys = [];
    var k = ds_map_find_first(dsmap);
    while (!is_undefined(k))
    {
        array_push(keys, k);
        k = ds_map_find_next(dsmap, k);
    }
    return keys;
}


/// scr_input_hint()
//
// Shows context-sensitive controls at the top-centre of the screen.
// Called from Draw GUI.
function scr_input_hint()
{
var pad_connected = gamepad_is_connected(0);

draw_set_font(font1);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_silver);

var msg = "";

if (pad_connected)
{
    msg = "LS ↑/↓  –  change team   |   LS ←/→  –  swap sides   |   START – Ready";
}
else
{
    msg = "W/S – change team   |   A/D – swap sides   |   ENTER – Ready";
}

draw_text(display_get_gui_width() * 0.5, 16, msg);
}