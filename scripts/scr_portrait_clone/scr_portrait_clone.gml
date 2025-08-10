/// scr_portrait_clone(p_any) -> portrait_struct (deep copy, safe)
var s = scr_portrait_ensure(argument0); // <-- normalize missing parts first

return {
    head:       { frame: s.head.frame,       color: s.head.color },
    hair:       { frame: s.hair.frame,       color: s.hair.color },
    beard:      { frame: s.beard.frame,      color: s.beard.color },
    mustache:   { frame: s.mustache.frame,   color: s.mustache.color },
    eyes:       { frame: s.eyes.frame,       color: s.eyes.color },
    nose:       { frame: s.nose.frame,       color: s.nose.color },
    mouth:      { frame: s.mouth.frame,      color: s.mouth.color },
    glasses:    { frame: s.glasses.frame,    color: s.glasses.color },
    jewelry:    { frame: s.jewelry.frame,    color: s.jewelry.color },
    shirt:      { frame: s.shirt.frame,      color: s.shirt.color }
};
