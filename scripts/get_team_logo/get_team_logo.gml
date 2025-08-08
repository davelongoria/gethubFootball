/// get_team_logo(team_name)
// Returns the sprite index for a team logo (custom > built-in > default)

function get_team_logo(team_name) {
    var obj = objBuiltInLogos; // Only one instance expected
    var t = string_lower(team_name);

    // Custom logo
    if (ds_map_exists(obj.logo_customs, t)) {
        return ds_map_find_value(obj.logo_customs, t);
    }
    // Built-in logo
    if (ds_map_exists(obj.logo_builtins, t)) {
        return ds_map_find_value(obj.logo_builtins, t);
    }
    // Fallback default
    return obj.default_logo;
}
