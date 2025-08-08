/// scr_safe_ds_map_keys(dsmap)
var dsmap = argument0;
if (is_undefined(dsmap) || !ds_exists(dsmap, ds_type_map)) return [];
var keys = [];
var _k = ds_map_find_first(dsmap);
while (!is_undefined(_k)) {
    array_push(keys, _k);
    _k = ds_map_find_next(dsmap, _k);
}
return keys;
