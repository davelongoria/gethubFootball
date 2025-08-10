/// scr_install_builtins_once()

function scr_install_builtins_once() {
    var mark = game_save_id + "extras/builtins_installed.txt";
    if (file_exists(mark)) return;

    var out_dir = game_save_id + "teams/";
    if (!directory_exists(out_dir)) directory_create(out_dir);

    // List the built-ins you ship in Included Files:
    var builtins = [
        "data/builtin/teams/Eagles.json",
        "data/builtin/teams/Broncos.json",
        // add all the ones you want to ship…
    ];

    for (var i = 0; i < array_length(builtins); i++) {
        var in_path  = builtins[i];
        var raw_json = string_load(in_path);
        if (string_length(raw_json) > 0) {
            // Keep original file name after the last slash
            var fname = in_path;
            var cut   = string_last_pos("/", in_path);
            if (cut > 0) fname = string_copy(in_path, cut + 1, string_length(in_path)-cut);

            string_save(out_dir + fname, raw_json);
        }
    }

    // Drop a marker so we don’t copy again
    string_save(mark, "ok");
}
