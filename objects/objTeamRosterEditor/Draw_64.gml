/// @desc objTeamRosterEditor — Draw GUI

// ---------- SAFETY: reset render state & choose a font ----------
shader_reset();
gpu_set_blendmode(bm_normal);
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Prefer your resource font; fall back to global.sprite font; else engine default
var f = asset_get_index("fntRosterLarge");
if (f != -1) {
    draw_set_font(f);
} else if (variable_global_exists("font") && is_real(global.font)) {
    draw_set_font(global.font);
} else {
    draw_set_font(-1);
}

var GW = display_get_gui_width();
var GH = display_get_gui_height();

// ---------- Soft-dim background (handled by editor; no separate dimmer) ----------
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_rectangle(0, 0, GW, GH, false);
draw_set_alpha(1);

// ---------- Title ----------
draw_set_color(c_white);
draw_text(24, 20, "TEAM + ROSTER EDITOR");

// ---------- Header block (team info) ----------
if (is_array(grid_data) && array_length(grid_data) > 0 && is_struct(grid_data[0]) && is_array(grid_data[0].fields)) {
    draw_text(24, 60,  "Team Name:");
    draw_text(24, 84,  "City:");
    draw_text(24, 108, "Abbr:");

    var hdr = grid_data[0].fields;
    draw_text(180, 60,  string(hdr[0]));
    draw_text(180, 84,  string(hdr[1]));
    draw_text(180, 108, string(hdr[2]));

    // Highlight header selection
    if (selected_row == 0) {
        var hx = 176 + selected_col * 160;
        var hy = 60 + selected_col * 24; // 0→60, 1→84, 2→108
        draw_set_color(c_yellow);
        draw_rectangle(hx - 6, hy - 2, hx + 300, hy + 18, true);
        draw_set_color(c_black);
        var hdr_text = string(hdr[selected_col]);
        draw_text(hx, hy, hdr_text);
        draw_set_color(c_white);
    }
} else {
    draw_set_color(c_yellow);
    draw_text(24, 60, "⚠ grid_data header missing");
    // early out prevents indexing errors
    exit;
}

// ---------- Column labels ----------
var labels_x = 24;
var labels_y = top_margin - 24;
for (var c = 0; c < array_length(col_labels); c++) {
    draw_text(labels_x + c * 150, labels_y, col_labels[c]);
}

// ---------- Player rows ----------
var start_i       = 1 + scroll_offset; // skip header (index 0)
var visible_rows  = floor((GH - top_margin) / row_height);
var end_i         = min(array_length(grid_data) - 1, start_i + visible_rows - 1);

var row_y = top_margin;
for (var i = start_i; i <= end_i; i++) {
    var row = grid_data[i];
    if (!is_struct(row) || row.type != "player") {
        row_y += row_height;
        continue;
    }

    // selection highlight line
    if (i == selected_row) {
        draw_set_color(make_color_rgb(48,48,72));
        draw_rectangle(20, row_y - 4, GW - 20, row_y + row_height - 4, false);
        draw_set_color(c_white);
    }

    // draw the row fields
    var fields = row.fields;
    if (!is_array(fields)) { row_y += row_height; continue; }

    for (var cc = 0; cc < array_length(fields); cc++) {
        var txt = string(fields[cc]);
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

// ---------- Footer hint ----------
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_text(GW * 0.5, GH - 28, keyboard_open
    ? "Type on the virtual keyboard. OK=Enter/Start, Cancel=Esc/B."
    : "↑/↓ rows, ←/→ cols, A/Enter edit, B/Esc exit");
