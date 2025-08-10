/// scr_portrait_random()
var p = scr_portrait_default();

p.head.color  = irandom_range(0, array_length(global.PAL_SKIN)-1);
p.nose.color  = p.head.color;
p.mouth.color = p.head.color;

var _hair_frames = max(1, sprite_exists(sprPortraitHair)    ? sprite_get_number(sprPortraitHair)    : 1);
var _beard_frames= max(1, sprite_exists(sprPortraitBeard)   ? sprite_get_number(sprPortraitBeard)   : 1);
var _stache_frames=max(1,sprite_exists(sprPortraitMuStash)  ? sprite_get_number(sprPortraitMuStash) : 1);
var _glasses_frames=max(1,sprite_exists(sprPortraitGlasses) ? sprite_get_number(sprPortraitGlasses) : 1);
var _jew_frames   = max(1, sprite_exists(sprPortraitJewelry)? sprite_get_number(sprPortraitJewelry) : 1);

p.hair.frame  = irandom(_hair_frames - 1);
p.hair.color  = irandom_range(0, array_length(global.PAL_HAIR)-1);

// 40% beard/stache chance
if (irandom(9) < 4) { p.beard.frame = irandom(_beard_frames - 1);  p.beard.color = p.hair.color; }
if (irandom(9) < 4) { p.mustache.frame = irandom(_stache_frames - 1); p.mustache.color = p.hair.color; }

// 15% glasses, 25% jewelry
if (irandom(99) < 15) p.glasses.frame = irandom(_glasses_frames - 1);
if (irandom(99) < 25) { p.jewelry.frame = irandom(_jew_frames - 1);
                         p.jewelry.color = irandom_range(0, array_length(global.PAL_JEWEL)-1); }

p.shirt.color = irandom_range(0, array_length(global.PAL_SHIRT)-1);
return p;
