/// @description Insert description here
// You can write your code in this editor
/// Draw LOS marker line
draw_self();

draw_set_color(c_aqua);
draw_set_alpha(1);
draw_rectangle(x - 2, 400, x + 2, 880, false); // 2 pixels wide
draw_set_alpha(1);
