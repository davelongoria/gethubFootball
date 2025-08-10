/// @desc objTeamRosterEditor — Draw GUI (no [?], no ternary)

// Reset render state
shader_reset();
gpu_set_blendmode(bm_normal);
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Bind a font
if (font_exists(fntRosterLarge)) {
    draw_set_font(fntRosterLarge);
} else if (variable_global_exists("__ui_font") && is_real(global.__ui_font) && global.__ui_font != -1) {
    draw_set_font(global.__ui_font);
} else {
    draw_set_font(-1);
}

// Soft-dim background
var GW = display_get_gui_width();
var GH = display_get_gui_height();
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_rectangle(0, 0, GW, GH, false);
draw_set_alpha(1);

// Title
draw_set_color(c_white);
draw_text(24, 20, "TEAM + ROSTER EDITOR");

// -------- header fields safely --------
var _hdr_ok = (is_array(grid_data) && array_length(grid_data) > 0 && is_struct(grid_data[0]) && is_array(grid_data[0].fields));
var _name_i = _hdr_ok ? string(grid_data[0].fields[0]) : "";
var _city_i = _hdr_ok ? string(grid_data[0].fields[1]) : "";
var _abbr_i = _hdr_ok ? string(grid_data[0].fields[2]) : "";

var _tname, _tcity, _tabbr;

// team name
if (variable_instance_exists(self,"team_name")) _tname = string(team_name);
else if (_name_i != "") _tname = _name_i;
else if (variable_global_exists("team_name")) _tname = string(global.team_name);
else _tname = "Generics";

// city
if (variable_instance_exists(self,"team_city")) _tcity = string(team_city);
else if (_city_i != "") _tcity = _city_i;
else if (variable_global_exists("team_city")) _tcity = string(global.team_city);
else _tcity = "Metro City";

// abbr
if (variable_instance_exists(self,"team_abbr")) _tabbr = string(team_abbr);
else if (_abbr_i != "") _tabbr = _abbr_i;
else if (variable_global_exists("team_abbr")) _tabbr = string(global.team_abbr);
else _tabbr = "GEN";

// -------- left: logo or portrait --------
var portrait_x = 40, portrait_y = 40, portrait_scale = 1.0;

if (selected_row == 0) {
    // TEAM LOGO via ds_map_find_value
    var _info_arr = undefined;
    if (variable_global_exists("team_info")) {
        if (ds_exists(global.team_info, ds_type_map)) {
            if (ds_map_exists(global.team_info, _tname)) {
                _info_arr = ds_map_find_value(global.team_info, _tname);
            }
        }
    }
    var logo_index = 0;
    if (is_array(_info_arr) && array_length(_info_arr) >= 4) logo_index = real(_info_arr[3]);

    if (sprite_exists(sprBuiltInLogos)) {
        draw_sprite(sprBuiltInLogos, clamp(logo_index, 0, sprite_get_number(sprBuiltInLogos)-1), portrait_x, portrait_y);
    } else {
        draw_text(portrait_x, portrait_y, "No Logo");
    }
} else {
    // PLAYER PORTRAIT
    if (_hdr_ok && selected_row < array_length(grid_data)) {
        var row = grid_data[selected_row];
        if (is_struct(row) && row.type == "player") {
            var idx = row.index;
            if (variable_global_exists("roster_editor_data") && is_array(global.roster_editor_data)) {
                if (idx >= 0 && idx < array_length(global.roster_editor_data)) {
                    var ply = global.roster_editor_data[idx];
                    if (is_struct(ply) && variable_struct_exists(ply,"portrait") && !is_undefined(ply.portrait)) {
                        scr_draw_player_portrait(ply.portrait, portrait_x, portrait_y, portrait_scale);
                    } else {
                        scr_draw_player_portrait(scr_portrait_default(), portrait_x, portrait_y, portrait_scale);
                    }
                }
            }
        }
    }
}

// optional yellow border when portrait box selected
if (selected_col == -1) {
    draw_set_color(c_yellow);
    draw_rectangle(portrait_x-2, portrait_y-2, portrait_x+192+2, portrait_y+192+2, false);
}

// -------- right info panel --------
var info_x_start = portrait_x + 400;
var info_y       = 40;

draw_set_color(c_white);
draw_text(info_x_start, info_y +   0, "TEAM NAME: " + _tname);
draw_text(info_x_start, info_y +  40, "CITY: "      + _tcity);
draw_text(info_x_start, info_y +  80, "ABBR: "      + _tabbr);
draw_text(info_x_start, info_y + 120, "College: N/A");
draw_text(info_x_start, info_y + 160, "Yrs Pro: N/A");
draw_text(info_x_start, info_y + 200, "Ht/Wt: N/A");
draw_text(info_x_start, info_y + 240, "Age: N/A");

// -------- header row (editable) --------
draw_set_color(c_white);
draw_text(24,  92, "Team Name:");
draw_text(24, 116, "City:");
draw_text(24, 140, "Abbr:");
draw_text(180,  92, _tname);
draw_text(180, 116, _tcity);
draw_text(180, 140, _tabbr);

// highlight selected header cell
if (selected_row == 0) {
    var hx = 176 + selected_col * 160;
    var hy =  92 + selected_col * 24;
    draw_set_color(c_yellow);
    draw_rectangle(hx - 6, hy - 2, hx + 300, hy + 18, true);
    draw_set_color(c_black);
    var _sel_txt = _tname;
    if (selected_col == 1) _sel_txt = _tcity;
    if (selected_col == 2) _sel_txt = _tabbr;
    draw_text(hx, hy, _sel_txt);
    draw_set_color(c_white);
}

// -------- column labels --------
var labels_y = top_margin - 24;
for (var c = 0; c < array_length(col_labels); c++) {
    draw_text(24 + c * 150, labels_y, col_labels[c]);
}

// -------- player grid --------
var start_i      = 1 + scroll_offset;
var visible_rows = floor((GH - top_margin) / row_height);
var end_i        = min(array_length(grid_data) - 1, start_i + visible_rows - 1);

var row_y = top_margin;
for (var i = start_i; i <= end_i; i++) {
    var r = grid_data[i];
    if (!is_struct(r) || r.type != "player") { row_y += row_height; continue; }

    if (i == selected_row) {
        draw_set_color(make_color_rgb(48,48,72));
        draw_rectangle(20, row_y - 4, GW - 20, row_y + row_height - 4, false);
        draw_set_color(c_white);
    }

    var f = r.fields;
    if (!is_array(f)) { row_y += row_height; continue; }

    for (var cc = 0; cc < array_length(f); cc++) {
        var txt = string(f[cc]);
        var cx  = 24 + cc * 150;

        if (i == selected_row && cc == selected_col) {
            draw_set_color(c_yellow);
            draw_rectangle(cx - 6, row_y - 2, cx + 140, row_y + 18, true);
            draw_set_color(c_black);
            draw_text(cx, row_y, txt);
            draw_set_color(c_white);
        } else {
            draw_text(cx, row_y, txt);
        }
    }

    row_y += row_height;
}

// -------- footer --------
draw_set_halign(fa_center);
draw_set_color(c_white);
if (keyboard_open) {
    draw_text(GW * 0.5, GH - 28, "Type on the virtual keyboard. OK=Enter/Start, Cancel=Esc/B.");
} else {
    draw_text(GW * 0.5, GH - 28, "↑/↓ rows, ←/→ cols, A/Enter edit, B/Esc exit");
}
draw_set_halign(fa_left);
