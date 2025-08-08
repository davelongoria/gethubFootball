/// objTextInput – Draw GUI Event
draw_set_color(c_black);
draw_rectangle(x-2, y-2, x + 120, y + 22, false);
draw_set_color(c_white);
draw_text(x, y, text);
draw_rectangle(x-2, y-2, x + 120, y + 22, true); // background fill
