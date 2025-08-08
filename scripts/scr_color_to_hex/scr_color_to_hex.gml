/// scr_color_to_hex(col)
// Converts a GameMaker color (BGR integer) to a string like "$FFFFFF"
// Returns "$FFFFFF" if value is bad.

var col = argument0;

if (is_undefined(col) || !is_real(col)) {
    col = $FFFFFF;
}
col = col & $FFFFFF; // Only keep bottom 24 bits

// Manual hex conversion (works in all GM versions)
var hex = "$";
var n = col;
for (var i = 0; i < 6; ++i) {
    var digit = (n >> ((5-i)*4)) & $F;
    if (digit < 10) hex += chr(ord("0")+digit);
    else hex += chr(ord("A")+digit-10);
}
return hex;
