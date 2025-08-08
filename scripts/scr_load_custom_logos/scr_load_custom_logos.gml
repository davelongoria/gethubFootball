/// scr_load_custom_logos()
/// Loads user logo sprites from the custom logos folder

global.custom_logos = [];

var custom_logo_folder = game_save_id + "data/custom/logos/";
if (!directory_exists(custom_logo_folder)) directory_create(custom_logo_folder);


// Search for files
var search_mask = custom_logo_folder + "*.*";
var file = file_find_first(search_mask, fa_readonly | fa_archive | fa_hidden | fa_sysfile | fa_volumeid | fa_directory);
var found_logo = false;

while (file != "") {
    // Exclude . and .. directories and subfolders
    if (file != "." && file != "..") {
        var file_path = custom_logo_folder + file;
        var ext = string_copy(file, string_length(file) - 2, 3);
        ext = string_lower(ext);

        // Only allow PNG, JPG, BMP
        if (ext == "png" || ext == "jpg" || ext == "bmp") {
            var spr = sprite_add(file_path, 1, false, false, 0, 0);
            if (spr != -1) {
                array_push(global.custom_logos, spr);
                found_logo = true;
            }
        }
    }
    file = file_find_next();
}
file_find_close();

// Add fallback if none found
if (!found_logo) {
    if (sprite_exists(sprCustomLogo)) {
        array_push(global.custom_logos, sprCustomLogo);
    }
}
