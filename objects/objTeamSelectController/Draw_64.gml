// --- TEAM SELECT DRAW GUI EVENT ---

// Color scheme (dark style)
var color_bg          = make_color_rgb(34, 34, 34);
var color_btn_idle    = make_color_rgb(40, 40, 40);
var color_btn_hover   = c_white  //make_color_rgb(80, 140, 250);
var color_btn_selected= c_white//make_color_rgb(50, 220, 70);
var color_text        = c_white;
var color_text_shadow = make_color_rgb(20, 20, 20);
var color_arrow       = make_color_rgb(220,220,40);

var btn_x      = display_get_gui_width()/2 - 120;
var btn_y_base = 180;
var btn_w      = 240;
var btn_h      = 55;
var btn_gap    = 18;

var menu_len = array_length(menu_buttons);

//draw_set_font(global.font); // Use your menu font
    draw_set_font(font1); // Use your menu font
// Draw all menu buttons
for (var i = 0; i < menu_len; ++i) {
    var this_btn_y = btn_y_base + i * (btn_h + btn_gap);
    var btn_col = color_btn_idle;
    if (selected == i) btn_col = color_btn_selected;
    else if (hovered == i) btn_col = color_btn_hover;

    // Button background
    draw_set_color(btn_col);
    draw_roundrect(btn_x, this_btn_y, btn_x+btn_w, this_btn_y+btn_h, false);

    // Button text (with slight shadow)
    draw_set_color(color_text_shadow);
    draw_text(btn_x + btn_w/4 + 62, this_btn_y + btn_h/4 + 2, menu_buttons[i]);
    draw_set_color(color_text);
    draw_text(btn_x + btn_w/4+60, this_btn_y + btn_h/4, menu_buttons[i]);
}

// --- "Edit Team" special UI: Team selector with arrows ---
if (menu_buttons[selected] == "Edit Team") {
    var team_sel_y = btn_y_base + selected*(btn_h+btn_gap);
    var team_sel_x = btn_x + btn_w + 36;
    var arrow_l_str = "<";
    var arrow_r_str = ">";
    var team_name = teams[edit_team_index];

    // Draw arrows and team name
    var arr_y = team_sel_y + btn_h/2;
    var arr_l_x = team_sel_x;
    var arr_r_x = team_sel_x + 160;
    var team_txt_x = team_sel_x + 42;

    // Get mouse pos in GUI
    var mx_gui = window_mouse_get_x();
    var my_gui = window_mouse_get_y();

    // Check mouse hover over arrows (for highlight)
    var over_l = (mx_gui > arr_l_x-16) && (mx_gui < arr_l_x+16) && (my_gui > arr_y-16) && (my_gui < arr_y+16);
    var over_r = (mx_gui > arr_r_x-16) && (mx_gui < arr_r_x+16) && (my_gui > arr_y-16) && (my_gui < arr_y+16);

    // Draw left arrow
    draw_set_color(over_l ? color_btn_hover : color_arrow);
    draw_text(arr_l_x, arr_y, arrow_l_str);

    // Draw right arrow
    draw_set_color(over_r ? color_btn_hover : color_arrow);
    draw_text(arr_r_x, arr_y, arrow_r_str);

    // Draw team name
    draw_set_color(color_text);
    draw_set_halign(fa_left);
    draw_text(team_txt_x, arr_y, team_name);
}
