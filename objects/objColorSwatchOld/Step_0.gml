/// objColorSwatch – Step  (left/right click cycles colour)

/* hit-test ------------------------------------------------------*/
var over   = point_in_rectangle(mouse_x, mouse_y, x, y, x + 32, y + 32);
var lclick = mouse_check_button_pressed(mb_left);
var rclick = mouse_check_button_pressed(mb_right);

/* exclusive selection ------------------------------------------*/
if (lclick && over) global.selected_sw = palette_index;
if (lclick && !over) global.selected_sw = -1;

if (global.selected_sw != palette_index) exit;   // not the active tile

/* decide delta --------------------------------------------------*/
var delta = 0;
if (lclick  && over) delta = +1;                 // left  click → next
if (rclick  && over) delta = -1;                 // right click → prev
if (keyboard_check_pressed(vk_right)) delta = +1;
if (keyboard_check_pressed(vk_left )) delta = -1;

if (delta == 0) exit;

/* locate current colour inside master list ---------------------*/
var cur_col = global.current_pal[palette_index];
var idx = 0;
while (idx < array_length(global.master_palette) &&
       global.master_palette[idx] != cur_col)
{
    idx++;
}
if (idx == array_length(global.master_palette)) idx = 0;   // fallback

/* get new colour -----------------------------------------------*/
var list_len = array_length(global.master_palette);
var new_idx  = (idx + delta + list_len) mod list_len;
var newc     = global.master_palette[new_idx];

/* write pixel & array ------------------------------------------*/
surface_set_target(global.pal_surf);
draw_set_colour(newc);
draw_point(palette_index, 0);
surface_reset_target();

global.current_pal[palette_index] = newc;
