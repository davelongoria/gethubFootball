/// objTeamSelectController  –  Step
//--------------------------------------------------------------
// Make sure these vars exist in Create:
/// selected, hovered, edit_team_index, menu_buttons[ ], teams[ ]
//--------------------------------------------------------------

var menu_len = array_length(menu_buttons);

//--------------------------------------------------------------
// 0. Mouse-over logic (unchanged)
//--------------------------------------------------------------
var mx_gui = device_mouse_x_to_gui(0);
var my_gui = device_mouse_y_to_gui(0);

var btn_x = 540, btn_w = 320, btn_h = 54;
var btn_y_start = 160, btn_gap = 20;

hovered = -1;
for (var i = 0; i < menu_len; ++i)
{
    var ry = btn_y_start + i * (btn_h + btn_gap);
    if (mx_gui > btn_x && mx_gui < btn_x+btn_w &&
        my_gui > ry   && my_gui < ry+btn_h)
        hovered = i;
}

//--------------------------------------------------------------
// 1. Input – up / down / select  (unchanged)
//--------------------------------------------------------------
var move_up  = keyboard_check_pressed(vk_up)    || gamepad_button_check_pressed(0, gp_padu);
var move_dn  = keyboard_check_pressed(vk_down)  || gamepad_button_check_pressed(0, gp_padd);
var confirm  = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"))
                                                || gamepad_button_check_pressed(0, gp_face1);

if (move_up) { selected = (selected-1+menu_len) mod menu_len;  audio_play_sound(sndSelect,1,false); }
if (move_dn) { selected = (selected+1)         mod menu_len;  audio_play_sound(sndSelect,1,false); }

if (mouse_check_button_pressed(mb_left) && hovered!=-1)
{ selected = hovered; audio_play_sound(sndSelect,1,false); }

//--------------------------------------------------------------
// 2. Arrow-left / right when Edit-Team is highlighted (unchanged)
//--------------------------------------------------------------
if (menu_buttons[selected]=="Edit Team")
{
    var tc = array_length(teams);
    if (keyboard_check_pressed(vk_left)  || gamepad_button_check_pressed(0, gp_padl))
    { edit_team_index = (edit_team_index-1+tc) mod tc; audio_play_sound(sndSelect,1,false); }
    if (keyboard_check_pressed(vk_right) || gamepad_button_check_pressed(0, gp_padr))
    { edit_team_index = (edit_team_index+1) mod tc;    audio_play_sound(sndSelect,1,false); }
}

//--------------------------------------------------------------
// 3.  Activate selection  (this is where we patch)
//--------------------------------------------------------------
if ( confirm || (mouse_check_button_released(mb_left) && hovered==selected) )
{
    switch (menu_buttons[selected])
    {
    //----------------------------------------------------------
    case "Quick Play":
        audio_play_sound(sndPressed,1,false);
        room_goto(rGame);
        break;

    case "Online Play":
        audio_play_sound(sndPressed,1,false);
        show_debug_message("[MENU] Online Play");
        break;

    case "Franchise":
        audio_play_sound(sndPressed,1,false);
        break;

    //----------------------------------------------------------
   case "Create Team":
{
    audio_play_sound(sndPressed,1,false);

    // 1. make a unique name
    var new_team_name = "New Team " + string( ds_map_size(global.team_palettes)+1 );

    // 2. clone the hard-coded “Default” palette (guaranteed 38 colours)
    var base_pal = array_create(38, 0);
    array_copy(base_pal, 0, global.team_palettes[? "Default"], 0, 38);

    // 3. register the palette & remember which team we’re editing
    global.team_palettes[? new_team_name] = base_pal;
    global.team_to_edit  = new_team_name;          // <-- the editor uses THIS

    // –––––––––––––––––––––––––––––––––––––––––––––––––––––––
    // 4. **CRUCIAL** – update these two globals before refresh
    global.current_pal   = base_pal;               // no need to deep-copy yet
    global.palette_size  = 38;                     // this was still the old size
    // –––––––––––––––––––––––––––––––––––––––––––––––––––––––

    scr_palette_surface_refresh();                 // rebuild 1-pixel surface
    global.selected_sw = -1;                       // no swatch selected

    room_goto(rmTeamEditor);
}
break;


    //----------------------------------------------------------
    case "Edit Team":
    {
        audio_play_sound(sndPressed,1,false);

        // 1.  Team being edited
        global.team_to_edit = teams[edit_team_index];   // <<<< use ONE variable consistently

        // 2.  Deep copy that palette (fallback to Default)
        var key = global.team_to_edit;
        var src = ds_map_exists(global.team_palettes,key)
                  ? global.team_palettes[? key]
                  : global.team_palettes[? "Default"];

        global.current_pal = array_create(array_length(src),0);
        array_copy(global.current_pal,0,src,0,array_length(src));
        scr_palette_surface_refresh();

        room_goto(rmTeamEditor);
    }
    break;

    //----------------------------------------------------------
    case "Settings":
        audio_play_sound(sndPressed,1,false);
        room_goto(rmSettings);
        break;

    case "Exit":
        audio_play_sound(sndPressed,1,false);
        game_end();
        break;
    }
}
