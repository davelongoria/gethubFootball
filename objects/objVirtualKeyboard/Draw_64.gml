/// objVirtualKeyboard – Draw

// --- Dim small rectangle behind keyboard only ---
var kb_w = 10*(key_width+4);
var kb_h =  5*(key_height+4);
var bg_x1 = keyboard_offset_x - 10;
var bg_y1 = keyboard_offset_y - 10;
var bg_x2 = keyboard_offset_x + kb_w + 10;
var bg_y2 = keyboard_offset_y + kb_h + 10;

draw_set_alpha(0.75);
draw_set_color(c_black);
draw_rectangle(bg_x1,bg_y1,bg_x2,bg_y2,true); // filled
draw_set_alpha(1);

// --- Draw keys ---
draw_set_font(font1_1);      // use your smaller font
for (var row=0; row<5; row++) {
    for (var col=0; col<10; col++) {
        var idx = row*10 + col;
        var ch  = keyboard_grid[idx];
        var xx  = keyboard_offset_x + col*(key_width+4);
        var yy  = keyboard_offset_y + row*(key_height+4);

        if (row==selected_row && col==selected_col) {
            draw_set_color(c_yellow);
            draw_rectangle(xx-2,yy-2,xx+key_width+2,yy+key_height+2,false);
        }
        draw_set_color(c_white);
        draw_text(xx + key_width div 2 - string_width(ch) div 2,
                  yy + key_height div 2 - string_height(ch) div 2,
                  ch);
    }
}

// --- Show current string directly above keyboard ---
draw_set_color(c_white);
draw_text(keyboard_offset_x, keyboard_offset_y - 36, current_string);
