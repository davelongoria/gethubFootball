/// objPortraitEditor.Create
// Inputs (set by spawner):
//   target_player_index : index into global.roster_editor_data
//   start_category      : optional (0..N-1)

if (!variable_instance_exists(id, "target_player_index")) target_player_index = -1;
if (!variable_global_exists("ui_overlay_active")) global.ui_overlay_active = false;
global.ui_overlay_active = true;

// --- pull player & portraits (safe) ---
if (target_player_index >= 0 && target_player_index < array_length(global.roster_editor_data)) {
    var pl = global.roster_editor_data[target_player_index];
    if (!is_struct(pl) || !variable_struct_exists(pl, "portrait") || is_undefined(pl.portrait)) {
        pl = { name:"UNKNOWN", pos:"UNK", speed:0, agility:0, tackle:0, durability:0, portrait:scr_portrait_default() };
        global.roster_editor_data[target_player_index] = pl;
    }
    original_portrait = scr_portrait_clone(pl.portrait); // keep original for Cancel
    edit_portrait     = scr_portrait_clone(pl.portrait); // working copy
} else {
    original_portrait = scr_portrait_default();
    edit_portrait     = scr_portrait_default();
}

// --- categories (frames auto-detected; palettes by name) ---
categories = [
    { name:"Head (Skin)",   key:"head",     frames:(sprite_exists(sprPortraitHead)      ? sprite_get_number(sprPortraitHead)      : 1), pal:"PAL_SKIN",  has_color:true,  allow_hide:false },
    { name:"Hair",          key:"hair",     frames:(sprite_exists(sprPortraitHair)      ? sprite_get_number(sprPortraitHair)      : 1), pal:"PAL_HAIR",  has_color:true,  allow_hide:true  },
    { name:"Beard",         key:"beard",    frames:(sprite_exists(sprPortraitBeard)     ? sprite_get_number(sprPortraitBeard)     : 1), pal:"PAL_HAIR",  has_color:true,  allow_hide:true  },
    { name:"Mustache",      key:"mustache", frames:(sprite_exists(sprPortraitMuStash)   ? sprite_get_number(sprPortraitMuStash)   : 1), pal:"PAL_HAIR",  has_color:true,  allow_hide:true  },
    { name:"Eyes",          key:"eyes",     frames:(sprite_exists(sprPortraitEyes)      ? sprite_get_number(sprPortraitEyes)      : 1), pal:"",          has_color:false, allow_hide:false },
    { name:"Glasses",       key:"glasses",  frames:(sprite_exists(sprPortraitGlasses)   ? sprite_get_number(sprPortraitGlasses)   : 1), pal:"",          has_color:false, allow_hide:true  },
    { name:"Jewelry",       key:"jewelry",  frames:(sprite_exists(sprPortraitJewelry)   ? sprite_get_number(sprPortraitJewelry)   : 1), pal:"PAL_JEWEL", has_color:true,  allow_hide:true  },
    { name:"Shirt",         key:"shirt",    frames:(sprite_exists(sprPortraitShirt)     ? sprite_get_number(sprPortraitShirt)     : 1), pal:"PAL_SHIRT", has_color:true,  allow_hide:false }
];

// start category (safe)
var _start_cat = 0;
if (variable_instance_exists(id, "start_category") && is_real(start_category)) _start_cat = start_category;
cat_index = clamp(_start_cat, 0, array_length(categories) - 1);

mode = 0;        // 0 = STYLE, 1 = COLOR
hide_value = -1; // -1 means hidden for allow_hide parts

// UI layout
panel_x = display_get_gui_width()/2 - 460;
panel_y = display_get_gui_height()/2 - 260;
panel_w = 920;
panel_h = 520;

portrait_x = panel_x + 680;
portrait_y = panel_y + 110;
portrait_scale = 1.0;
