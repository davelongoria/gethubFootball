/// scr_draw_player_portrait(portrait_any, x, y, scale)

// palettes safety (in case init wasn’t called yet)
if (!variable_global_exists("PAL_SKIN"))  scr_portrait_palettes_init();

// ----- Safe args -----
var P  = scr_portrait_ensure(argument0);
var _x = (argument_count >= 2 && is_real(argument1)) ? argument1 : 0;
var _y = (argument_count >= 3 && is_real(argument2)) ? argument2 : 0;
var sc = (argument_count >= 4 && is_real(argument3)) ? argument3 : 1;

// ----- Helpers -----
function _tint(arr, idx) {
    if (is_array(arr) && idx >= 0 && idx < array_length(arr)) return arr[idx];
    return c_white;
}

var skin_col  = _tint(global.PAL_SKIN,  P.head.color);
var hair_col  = _tint(global.PAL_HAIR,  P.hair.color);
var jew_col   = _tint(global.PAL_JEWEL, P.jewelry.color);
var shirt_col = _tint(global.PAL_SHIRT, P.shirt.color);

// ----- Draw stack -----
if (sprite_exists(sprPortraitBase))
    draw_sprite_ext(sprPortraitBase, 0, _x, _y, sc, sc, 0, c_white, 1);

if (sprite_exists(sprPortraitShirt))
    draw_sprite_ext(sprPortraitShirt, P.shirt.frame, _x, _y, sc, sc, 0, shirt_col, 1);

if (sprite_exists(sprPortraitHead))
    draw_sprite_ext(sprPortraitHead, P.head.frame, _x, _y, sc, sc, 0, skin_col, 1);

if (sprite_exists(sprPortraitEyes) && P.eyes.frame >= 0)
    draw_sprite_ext(sprPortraitEyes, P.eyes.frame, _x, _y, sc, sc, 0, c_white, 1);

if (sprite_exists(sprPortraitNose) && P.nose.frame >= 0)
    draw_sprite_ext(sprPortraitNose, P.nose.frame, _x, _y, sc, sc, 0, skin_col, 1);

if (sprite_exists(sprPortraitMouth) && P.mouth.frame >= 0)
    draw_sprite_ext(sprPortraitMouth, P.mouth.frame, _x, _y, sc, sc, 0, skin_col, 1);

if (sprite_exists(sprPortraitHair) && P.hair.frame >= 0)
    draw_sprite_ext(sprPortraitHair, P.hair.frame, _x, _y, sc, sc, 0, hair_col, 1);

if (sprite_exists(sprPortraitBeard) && P.beard.frame >= 0)
    draw_sprite_ext(sprPortraitBeard, P.beard.frame, _x, _y, sc, sc, 0, hair_col, 1);

if (sprite_exists(sprPortraitMuStash) && P.mustache.frame >= 0)
    draw_sprite_ext(sprPortraitMuStash, P.mustache.frame, _x, _y, sc, sc, 0, hair_col, 1);

if (sprite_exists(sprPortraitGlasses) && P.glasses.frame >= 0)
    draw_sprite_ext(sprPortraitGlasses, P.glasses.frame, _x, _y, sc, sc, 0, c_white, 1);

if (sprite_exists(sprPortraitJewelry) && P.jewelry.frame >= 0)
    draw_sprite_ext(sprPortraitJewelry, P.jewelry.frame, _x, _y, sc, sc, 0, jew_col, 1);
