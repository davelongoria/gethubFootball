// Set up built-in logo sprite (all built-ins as frames)
builtin_sprite = sprBuiltInLogosSmall; // replace with your actual multi-frame sprite
num_builtins = sprite_get_number(builtin_sprite); // number of built-in frames

// Load custom logos (these are loaded into global.custom_logos)
scr_load_custom_logos(); // Don't pass any arguments

frame = 0;
total_logos = num_builtins + array_length(global.custom_logos);
