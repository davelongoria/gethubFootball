/// @desc objWRParent – Create  (2025-06-22, safe assignments)

/* ── core state flags ── */
hasBall        = false;
caught         = false;
jumping        = false;
returning      = false;
celebrating    = false;
player_controlled = false;

/* ── movement & pathing ── */
wr_speed       = 3;
wr_index       = 0;           // each child (WR1-WR5) overrides this
jump_height    = 8;

assigned_path  = "Path5";
path_started   = false;
path_pending   = true;        // first snap launches route
route_finished = false;

/* ── LOS offsets (for clean resets) ── */
start_x        = x;
start_y        = y;
start_offset_x = x - objScrimmageMarker.x;
start_offset_y = y - objScrimmageMarker.y;

/* ── visuals ── */
sprite_index   = sorWrPreSnapgry;
image_speed    = 0.2;

/* ── input & timers ── */
move_x = 0;
move_y = 0;
flash_timer       = 0;
celebration_timer = 0;

/* ✨  velocity tracking so sprites match real movement */
prev_x = x;
prev_y = y;
/* touchdown‐run variables (default = not celebrating) */
celebrate_buffer   = 0;
celebrate_target_x = x;
