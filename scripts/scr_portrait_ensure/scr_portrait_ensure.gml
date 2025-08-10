/// scr_portrait_ensure(portrait_any) -> portrait_struct
/// Guarantees a complete portrait struct with all sub-objects {frame,color}
var P = argument0;

// start with default if missing/invalid
if (!is_struct(P)) P = scr_portrait_default();

// ensure each part exists
function _ensure_part(obj, def_frame, def_color) {
    if (!is_struct(obj)) return { frame: def_frame, color: def_color };
    if (!variable_struct_exists(obj, "frame")) obj.frame = def_frame;
    if (!variable_struct_exists(obj, "color")) obj.color = def_color;
    return obj;
}

var D = scr_portrait_default();

P.head     = _ensure_part(variable_struct_exists(P,"head")     ? P.head     : undefined, D.head.frame,     D.head.color);
P.hair     = _ensure_part(variable_struct_exists(P,"hair")     ? P.hair     : undefined, D.hair.frame,     D.hair.color);
P.beard    = _ensure_part(variable_struct_exists(P,"beard")    ? P.beard    : undefined, D.beard.frame,    D.beard.color);
P.mustache = _ensure_part(variable_struct_exists(P,"mustache") ? P.mustache : undefined, D.mustache.frame, D.mustache.color);
P.eyes     = _ensure_part(variable_struct_exists(P,"eyes")     ? P.eyes     : undefined, D.eyes.frame,     D.eyes.color);
P.nose     = _ensure_part(variable_struct_exists(P,"nose")     ? P.nose     : undefined, D.nose.frame,     D.nose.color);
P.mouth    = _ensure_part(variable_struct_exists(P,"mouth")    ? P.mouth    : undefined, D.mouth.frame,    D.mouth.color);
P.glasses  = _ensure_part(variable_struct_exists(P,"glasses")  ? P.glasses  : undefined, D.glasses.frame,  D.glasses.color);
P.jewelry  = _ensure_part(variable_struct_exists(P,"jewelry")  ? P.jewelry  : undefined, D.jewelry.frame,  D.jewelry.color);
P.shirt    = _ensure_part(variable_struct_exists(P,"shirt")    ? P.shirt    : undefined, D.shirt.frame,    D.shirt.color);

return P;
