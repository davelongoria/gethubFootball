/// @desc objVirtualKeyboard — Create

// Public flags that the editor polls
finished     = false;   // set true on OK/Start/Enter
cancelled    = false;   // set true on Esc/B
output_text  = "";      // final result to pass back

// Incoming seed text / labels (safe defaults)
if (!variable_instance_exists(self, "input_text"))   input_text = "";
if (!variable_instance_exists(self, "prompt"))       prompt     = "Enter Text";
if (!variable_instance_exists(self, "ok_label"))     ok_label   = "OK";
if (!variable_instance_exists(self, "cancel_label")) cancel_label = "Cancel";

// Internal state
cursor_row   = 0;       // 0..3 (4 rows of keys)
cursor_col   = 0;       // 0..9 (10 columns per row)
blink_timer  = 0;

// Precompute keyboard array (matches scr_get_keyboard_char layout)
keys = [
    "A","B","C","D","E","F","G","H","I","J",
    "K","L","M","N","O","P","Q","R","S","T",
    "U","V","W","X","Y","Z","0","1","2","3",
    "4","5","6","7","8","9","_","-","←", ok_label  // last two: backspace & OK
];

// Visual layout
cell_w   = 48;
cell_h   = 32;
grid_cols= 10;
grid_rows= 4;
pad_x    = 40;
pad_y    = 160;

gui_w    = display_get_gui_width();
gui_h    = display_get_gui_height();
