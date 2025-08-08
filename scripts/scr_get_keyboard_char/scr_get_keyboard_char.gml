/// @function scr_get_keyboard_char(_row, _col)
/// @param {real} _row - The selected row index
/// @param {real} _col - The selected column index

var _row = argument0;
var _col = argument1;

// Validate arguments
if (is_undefined(_row)) _row = 0;
if (is_undefined(_col)) _col = 0;

// Define keyboard layout (10 columns per row)
var keyboard = [
    "A","B","C","D","E","F","G","H","I","J",
    "K","L","M","N","O","P","Q","R","S","T",
    "U","V","W","X","Y","Z","0","1","2","3",
    "4","5","6","7","8","9","_","-"," ","←","OK"
];

var index = _row * 10 + _col;

// Clamp index to safe range
index = clamp(index, 0, array_length(keyboard) - 1);

// Return the character at this index
return keyboard[index];
