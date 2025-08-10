/// objPortraitEditor.Step

// --- SAVE & CLOSE: Start or A ---
if (gamepad_button_check_pressed(0, gp_start) || gamepad_button_check_pressed(0, gp_face1)) {
    if (target_player_index >= 0 && target_player_index < array_length(global.roster_editor_data)) {
        var pl = global.roster_editor_data[target_player_index];
        if (is_struct(pl)) pl.portrait = scr_portrait_clone(edit_portrait);
    }
    global.ui_overlay_active = false;
    global.input_eat_frames = 2; // swallow Start/A so roster doesn't react
    if (object_exists(objModalDimmer)) with (objModalDimmer) visible = true;
    instance_destroy();
    exit;
}

// --- CANCEL (revert) & CLOSE: Y or Esc ---
if (gamepad_button_check_pressed(0, gp_face4) || keyboard_check_pressed(vk_escape)) {
    if (target_player_index >= 0 && target_player_index < array_length(global.roster_editor_data)) {
        var pl2 = global.roster_editor_data[target_player_index];
        if (is_struct(pl2)) pl2.portrait = scr_portrait_clone(original_portrait);
    }
    global.ui_overlay_active = false;
    global.input_eat_frames = 2; // swallow Y/Esc
    if (object_exists(objModalDimmer)) with (objModalDimmer) visible = true;
    instance_destroy();
    exit;
}

// --- CLOSE w/o save: B (let roster catch B for its exit flow) ---
if (gamepad_button_check_pressed(0, gp_face2)) {
    global.ui_overlay_active = false;
    if (object_exists(objModalDimmer)) with (objModalDimmer) visible = true;
    instance_destroy();
    exit;
}

// Category nav
if (keyboard_check_pressed(vk_up) || gamepad_button_check_pressed(0, gp_padu)) {
    cat_index = (cat_index - 1 + array_length(categories)) mod array_length(categories);
}
if (keyboard_check_pressed(vk_down) || gamepad_button_check_pressed(0, gp_padd)) {
    cat_index = (cat_index + 1) mod array_length(categories);
}

// Toggle edit mode (STYLE <-> COLOR) with X
if (gamepad_button_check_pressed(0, gp_face3)) {
    var c0 = categories[cat_index];
    if (c0.has_color) mode = 1 - mode;
}

// Change value left/right
var go_left  = keyboard_check_pressed(vk_left)  || gamepad_button_check_pressed(0, gp_padl);
var go_right = keyboard_check_pressed(vk_right) || gamepad_button_check_pressed(0, gp_padr);

if (go_left || go_right) {
    var c  = categories[cat_index];
    var ky = c.key;
    var ref = variable_struct_get(edit_portrait, ky); // {frame,color}

    if (mode == 0) {
        var max_frames = max(1, c.frames);
        if (c.allow_hide) {
            var cur = ref.frame;
            if (go_right) cur++; else cur--;
            if (cur > max_frames - 1) cur = -1;
            if (cur < -1) cur = max_frames - 1;
            ref.frame = cur;
        } else {
            ref.frame = ((ref.frame + (go_right ? 1 : -1)) + max_frames) mod max_frames;
        }
    } else {
        var pal = [];
        if (c.pal == "PAL_SKIN")  pal = global.PAL_SKIN;
        if (c.pal == "PAL_HAIR")  pal = global.PAL_HAIR;
        if (c.pal == "PAL_JEWEL") pal = global.PAL_JEWEL;
        if (c.pal == "PAL_SHIRT") pal = global.PAL_SHIRT;

        if (array_length(pal) > 0) {
            var len  = array_length(pal);
            var curc = max(0, ref.color);
            curc = (curc + (go_right ? 1 : -1) + len) mod len;
            ref.color = curc;

            if (ky == "head") {
                edit_portrait.nose.color  = ref.color;
                edit_portrait.mouth.color = ref.color;
            }
            if (ky == "hair") {
                edit_portrait.beard.color    = ref.color;
                edit_portrait.mustache.color = ref.color;
            }
        }
    }

    variable_struct_set(edit_portrait, ky, ref);
}
