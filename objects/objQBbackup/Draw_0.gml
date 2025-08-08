/// @description Insert description here
// You can write your code in this editor
//draw_self();

/////debug text

if (!can_throw) {
    draw_text(x, y - 48, "QB Cooldown: " + string(ceil(throw_cooldown / 30)) + "s");
} else if (key_held != -1) {
    draw_text(x, y - 48, "Charging " + string(throw_charge));
}
if (pocket_aiming) {
    // White dots
    for (var i = 0; i < dot_count - 1; i++) {
        var px = pocket_arc[i][0];
        var py = pocket_arc[i][1];
        draw_circle_color(px, py, 4, c_white, c_white, false);
    }
    // Red X at final point
    var ex = pocket_arc[dot_count - 1][0];
    var ey = pocket_arc[dot_count - 1][1];
    draw_set_color(c_red);
    draw_line(ex - 6, ey - 6, ex + 6, ey + 6);
    draw_line(ex - 6, ey + 6, ex + 6, ey - 6);
    draw_set_color(c_white);
}



////palette
var sc = 1;
shader_set(shdPaletteTex);
draw_sprite_ext(sprite_index, image_index, x, y, sc, sc, 0, c_white, 1);
shader_reset();