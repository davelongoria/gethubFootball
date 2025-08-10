/// DIAG: objTeamRosterEditor — Draw GUI (minimal, no fonts, no helpers)

// Hard reset state
shader_reset();
gpu_set_blendmode(bm_normal);
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Force engine default font (avoids any font resource issues)
draw_set_font(-1);

// Dim so we know this event is running
var GW = display_get_gui_width();
var GH = display_get_gui_height();
draw_set_alpha(0.25);
draw_set_color(c_black);
draw_rectangle(0, 0, GW, GH, false);
draw_set_alpha(1);

// BIG PROBE
draw_set_color(c_white);
draw_text(24, 24, "EDITOR DRAW DIAG: if you see this, Draw GUI is running");

// Show whether other overlays exist (could be covering you)
draw_text(24, 50, "Instances: ModalDimmer=" + string(instance_exists(objModalDimmer)) 
                    + "  ExitConfirm=" + string(instance_exists(objExitConfirm))
                    + "  VirtualKB=" + string(instance_exists(objVirtualKeyboard)));

// Show some state from Create/Step
var has_grid  = is_array(grid_data) ? array_length(grid_data) : -1;
var has_roster= (variable_global_exists("roster_editor_data") && is_array(global.roster_editor_data)) ? array_length(global.roster_editor_data) : -1;
draw_text(24, 74, "grid_data length=" + string(has_grid) + "   roster_editor_data length=" + string(has_roster));
draw_text(24, 98, "selected_row=" + string(selected_row) + "  selected_col=" + string(selected_col) + "  scroll_offset=" + string(scroll_offset));

// Draw FIRST THREE PLAYERS directly from global.roster_editor_data (no grid, no helpers)
var _y = 140;
draw_set_color(c_yellow);
draw_text(24, _y - 24, "FIRST 3 PLAYERS FROM global.roster_editor_data (raw)");

if (has_roster > 0) {
    var max_show = min(3, has_roster);
    for (var i = 0; i < max_show; i++) {
        var p = global.roster_editor_data[i];
        if (is_struct(p)) {
            var line = "[" + string(i) + "] "
                     + (variable_struct_exists(p,"name") ? string(p.name) : "<no name>")
                     + "  pos=" + (variable_struct_exists(p,"pos") ? string(p.pos) : "-")
                     + "  spd=" + (variable_struct_exists(p,"speed") ? string(p.speed) : "-");
            draw_set_color(c_white);
            draw_text(24, _y, line);
            _y += 22;

            // Try drawing portrait *only* if the portrait struct exists
            if (variable_struct_exists(p,"portrait") && !is_undefined(p.portrait)) {
                // draw a placeholder box so we know where it would go
                draw_set_color(c_ltgray);
                draw_rectangle(560, 120, 560+96, 120+96, false);

                // If your portrait stack is valid, this should render; if not, we still see the rectangle.
                // Comment out if you suspect portrait stack is crashing.
                // scr_draw_player_portrait(p.portrait, 560, 120, 1);
            }
        } else {
            draw_set_color(c_red);
            draw_text(24, _y, "[" + string(i) + "] <not a struct>");
            _y += 22;
        }
    }
} else {
    draw_set_color(c_red);
    draw_text(24, _y, "No roster data in global.roster_editor_data");
}
