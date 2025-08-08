/// scr_commit_roster_edits_to_template()
//
// Copies ALL edits from the open roster-editor overlay back into:
//   • global.roster_editor_data         (session array)
//   • global.teams["TEMPLATE"].roster   (template struct)
//   • global.team_name / city / abbr    (for UI)
//   • global.team_info["TEMPLATE"]      (so Create() reads new header)
//
// Call this once when the player confirms “YES – save”.

//--------------------------------------------------
// A. Get the open roster-editor instance
//--------------------------------------------------
var ro = instance_find(objTeamRosterEditor, 0);
if (!instance_exists(ro)) {
    show_debug_message("❌ roster editor not open – commit aborted");
    return;
}

//--------------------------------------------------
// B. Header strings (Team Name / City / Abbr)
//--------------------------------------------------
var team_name  = ro.team_name;
var team_city  = ro.team_city;
var team_abbr  = ro.team_abbr;

// 1️⃣  store to convenience globals (Create event reads these)
global.team_name  = team_name;
global.team_city  = team_city;
global.team_abbr  = team_abbr;

//--------------------------------------------------
// C. Ensure TEMPLATE struct exists
//--------------------------------------------------
if (!variable_global_exists("teams") || !ds_map_exists(global.teams, "TEMPLATE")) {
    show_debug_message("❌ TEMPLATE team not found – commit aborted");
    return;
}
var tmpl = global.teams[? "TEMPLATE"];

//--------------------------------------------------
// D. Copy player rows back into session array
//--------------------------------------------------
var rows = array_length(ro.grid_data);

if (!variable_global_exists("roster_editor_data") || array_length(global.roster_editor_data) != rows)
    global.roster_editor_data = array_create(rows, 0);

for (var r = 0; r < rows; r++)
{
    var row = ro.grid_data[r];
    if (row.type != "player") continue;

    var idx = row.index;
    if (idx >= array_length(global.roster_editor_data)) continue;

    var ply = global.roster_editor_data[idx];
    if (!is_struct(ply)) ply = {};                  // safeguard

    // row.fields = [name,pos,speed,agility,tackle,durability]
    ply.name       = row.fields[0];
    ply.pos        = row.fields[1];
    ply.speed      = real(row.fields[2]);
    ply.agility    = real(row.fields[3]);
    ply.tackle     = real(row.fields[4]);
    ply.durability = real(row.fields[5]);

    global.roster_editor_data[idx] = ply;           // write back
}

//--------------------------------------------------
// E. Push edits into TEMPLATE struct
//--------------------------------------------------
tmpl.roster     = global.roster_editor_data;
tmpl.team_name  = team_name;
tmpl.city       = team_city;
tmpl.team_abbr  = team_abbr;

//--------------------------------------------------
// F. Update global.team_info map (header persistence)
//--------------------------------------------------
if (!variable_global_exists("team_info"))
    global.team_info = ds_map_create();

var info_arr;
if (ds_map_exists(global.team_info, "TEMPLATE"))
    info_arr = global.team_info[? "TEMPLATE"];
else
    info_arr = ["", "", "", 0];

info_arr[0] = team_name;
info_arr[1] = team_city;
info_arr[2] = team_abbr;
global.team_info[? "TEMPLATE"] = info_arr;

//--------------------------------------------------
// G. Debug log
//--------------------------------------------------
show_debug_message("✅ commit complete – header + " + string(rows) + " players saved to TEMPLATE");
