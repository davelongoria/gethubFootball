// Reset position relative to new LOS
x = objScrimmageMarker.x + start_x;
y = start_y;

// Reset sprite and state
if (sprite_index != spr_idle) sprite_index = spr_idle;
is_grappling = false;
grapple_timer = 0;
pancaked = false;
pancake_timer = 0;
