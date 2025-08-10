/// @desc objTeamRosterEditor — Create
depth = -100002; // draw after most things that accidentally use non-GUI draw

// ---------- Editor core ----------
selected_row    = 0;
selected_col    = 0;
scroll_offset   = 0;
row_height      = 28;
top_margin      = 120;

// ---------- Header / team strings ----------
team_name = (variable_global_exists("team_name") && is_string(global.team_name)) ? global.team_name : "Generics";
team_city = (variable_global_exists("team_city") && is_string(global.team_city)) ? global.team_city : "Metro City";
team_abbr = (variable_global_exists("team_abbr") && is_string(global.team_abbr)) ? global.team_abbr : "GEN";

// ---------- Build grid_data from session ----------
grid_data = [];

function _mk_player_row(idx, ply) {
    var f = [
        string(ply.name),
        string(ply.pos),
        string(ply.speed),
        string(ply.agility),
        string(ply.tackle),
        string(ply.durability)
    ];
    return { type: "player", index: idx, fields: f };
}

if (!variable_global_exists("roster_editor_data") || !is_array(global.roster_editor_data)) {
    global.roster_editor_data = [];
}

// Header (row 0)
array_push(grid_data, { type: "header", fields: [team_name, team_city, team_abbr] });

// Players
for (var i = 0; i < array_length(global.roster_editor_data); i++) {
    var p = global.roster_editor_data[i];
    if (is_struct(p)) array_push(grid_data, _mk_player_row(i, p));
}

// ---------- Virtual keyboard state ----------
keyboard_open       = false;
keyboard_finished   = false;
keyboard_cancelled  = false;
keyboard_text       = "";
keyboard_target_row = -1;
keyboard_target_col = -1;

// ---------- Edit mode ----------
is_editing = false;

// ---------- Flags ----------
global.roster_editor_active = true;

// ---------- Column labels ----------
col_labels = ["NAME","POS","SPD","AGI","TCK","DUR"];
show_debug_message("Editor grid rows = " + string(array_length(grid_data)));
