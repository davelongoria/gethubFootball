//////////////////////////////////////////////////////////////////////////////
// objTeamRosterEditor – Create Event  (FULL, UPDATED)
//////////////////////////////////////////////////////////////////////////////

depth = -10001;

//--------------------------------------------------
// 1. Default globals for header strings
//--------------------------------------------------
if (!variable_global_exists("team_name")) global.team_name = "DEFAULT";
if (!variable_global_exists("team_city")) global.team_city = "City";
if (!variable_global_exists("team_abbr")) global.team_abbr = "DEF";

team_name  = global.team_name;
team_city  = global.team_city;
team_abbr  = global.team_abbr;

//--------------------------------------------------
// 2. Overlay flag
//--------------------------------------------------
if (!variable_global_exists("ui_overlay_active"))
    global.ui_overlay_active = false;

//--------------------------------------------------
// 3. Layout & navigation vars
//--------------------------------------------------
grid_offset_y = 200;
scroll_col    = 0;

row_height    = 40;
col_positions = [100, 400, 600, 720, 840, 960];
scroll_y      = 0;

active_row  = 0;
active_col  = 0;
is_editing  = false;
is_dragging = false;

//--------------------------------------------------
// 4. Ensure data structures exist
//--------------------------------------------------
if (!variable_global_exists("team_info")) global.team_info = ds_map_create();
if (!variable_global_exists("teams"))     global.teams     = ds_map_create();
if (!variable_global_exists("roster_editor_data"))
    global.roster_editor_data = [];

//--------------------------------------------------
// 5. Determine team to edit
//--------------------------------------------------
var teamname = (variable_global_exists("team_to_edit"))
             ? global.team_to_edit
             : "TEMPLATE";

//--------------------------------------------------
// 6. Build grid_data array
//--------------------------------------------------
grid_data = [];

// ----- Header row -----
var info_arr;
if (ds_map_exists(global.team_info, teamname))
    info_arr = global.team_info[? teamname];
else {
    info_arr = ["", "", "", 0];
    global.team_info[? teamname] = info_arr;
}

array_push(grid_data,
    { type:"info", group:"TEAM",
      fields:[ info_arr[0], info_arr[1], info_arr[2] ] }
);

// ----- Player rows grouped by position -----
var position_groups = ["QB","RB","FB","WR","TE",
                       "OL","DL","LB","CB","S","K","P","LS"];

for (var g = 0; g < array_length(position_groups); g++)
{
    var group = position_groups[g];

    for (var i = 0; i < array_length(global.roster_editor_data); i++)
    {
        var p = global.roster_editor_data[i];

        // ---------- SAFEGUARD ----------
        if (!is_struct(p)) {
            // convert legacy / bad entry to minimal struct
            p = {
                name:"UNKNOWN",
                pos :"UNK",
                speed:0,
                agility:0,
                tackle:0,
                durability:0
            };
            global.roster_editor_data[i] = p;   // store back
        }
        else if (!variable_struct_exists(p,"pos")) {
            p.pos = "UNK";
        }

        // --------- grouping logic ---------
        var match = false;
        if (group == "S")        match = (p.pos == "FS" || p.pos == "SS");
        else if (group == "DL")  match = (p.pos == "DT" || p.pos == "DE");
        else if (group == "OL")  match = (string_pos("OL", p.pos) > 0);
        else                     match = (p.pos == group);

        if (match)
        {
            array_push(grid_data,
                { type:"player", group:group, index:i,
                  fields:[
                    p.name,
                    p.pos,
                    string(p.speed),
                    string(p.agility),
                    string(p.tackle),
                    string(p.durability)
                  ]
                });
        }
    }
}

//--------------------------------------------------
// 7. Flag overlay active
//--------------------------------------------------
global.roster_editor_active = true;
