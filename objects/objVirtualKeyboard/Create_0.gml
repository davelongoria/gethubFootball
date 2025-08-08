/// objVirtualKeyboard - Create Event
depth = -10002;
/// objVirtualKeyboard – Create

// -----------------------------------
//  Keyboard visual & placement
// -----------------------------------
key_width  = 32;
key_height = 32;

// ► EDIT THESE TWO LINES TO MOVE UI ◄
keyboard_offset_x = (display_get_gui_width()  - 10*(key_width+4)) div 2;
keyboard_offset_y = (display_get_gui_height()*2 div 3);

// -----------------------------------
//  Keyboard layout (50 keys, 10×5)
//  row4 has nine “<” (backspace) + OK
// -----------------------------------
keyboard_grid = [
 "A","B","C","D","E","F","G","H","I","J",
 "K","L","M","N","O","P","Q","R","S","T",
 "U","V","W","X","Y","Z","0","1","2","3",
 "4","5","6","7","8","9"," ","-","_",".",
 "<","<","<","<","<","<","<","<","<","OK"
];

// -----------------------------------
//  Editing state
// -----------------------------------
selected_row   = 0;
selected_col   = 0;
current_string = "";
max_chars      = 24;

// These are overwritten by the roster editor
target_row = 0;
target_col = 0;

// Block inputs underneath
global.ui_overlay_active = true;

// Optional sound-checks
if (!audio_exists(sndSelect))  show_debug_message("⚠ sndSelect missing");
if (!audio_exists(sndPressed)) show_debug_message("⚠ sndPressed missing");
