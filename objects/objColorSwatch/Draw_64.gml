
if (global.roster_editor_active) exit;
// objColorSwatch Draw Event

var col = global.current_pal[palette_index];
draw_set_colour(col);
draw_rectangle(x, y, x+32, y+32, false);

if (point_in_rectangle(mouse_x, mouse_y, x, y, x+32, y+32) || global.selected_sw == palette_index) {
    draw_set_colour(c_white);
    draw_rectangle(x-1, y-1, x+33, y+33, true);
}
