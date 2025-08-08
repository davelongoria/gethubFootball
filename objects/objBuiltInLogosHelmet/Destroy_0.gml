// Clean up loaded user logo sprites to prevent memory leaks
if (array_length(global.custom_logos) > 0) {
    for (var i = 0; i < array_length(global.custom_logos); i++) {
        if (sprite_exists(global.custom_logos[i])) {
            sprite_delete(global.custom_logos[i]);
        }
    }
}
