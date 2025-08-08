/// scr_PocketPasser – Pocket pass with robust variable handling
/// Call from QB Step: if (scr_PocketPasser()) return;
/*
// --- TUNING VARIABLES (Adjust these!) ---
var pull_enter_threshold     = 0.35;  // Stick pull to ENTER aiming
var pull_release_threshold   = 0.20;  // Stick let-go to FIRE throw
var pocket_cooldown_frames   = 30;    // Frames after throw/cancel before re-aim

var hand_offset_x            = 32;    // QB hand offset X (pixels)
var hand_offset_y            = 22;    // QB hand offset Y (pixels)

var max_throw_distance       = 900;   // FARTHEST pass (when stick fully back)
var min_throw_distance       = 50;   // CLOSEST pass (just barely pulled)

var max_arc_height           = 300;   // Highest rainbow lob
var min_arc_height           = 150;    // Flattest

var speed_divisor            = 24;    // Lower = faster ball speed
var min_throw_speed          = 2;
var max_throw_speed          = 5;

var pull_curve_exponent      = 8.8;   // >1 makes mid-pull slower/longer

var dot_count                = 12;    // Number of preview dots (must match Create)
var min_flight_frames        = 6;
var max_flight_frames        = 60;

// --- Defensive: Make sure all needed variables exist ---
if (!variable_instance_exists(self, "pocket_aiming")) return false;
if (!variable_instance_exists(self, "dot_count"))     return false;
if (!variable_instance_exists(self, "pocket_arc"))    return false;
if (!variable_instance_exists(self, "hiked"))         return false;
if (!variable_instance_exists(self, "attached_to"))   return false;
if (!variable_instance_exists(self, "pocket_cooldown")) return false;

// --- Only run when hiked and you have the ball ---
if (!hiked || attached_to != id) return false;
if (pocket_cooldown > 0) pocket_cooldown--;

// --- Input ---
var lx = gamepad_axis_value(0, gp_axislh);
var ly = gamepad_axis_value(0, gp_axislv);
var pull = point_distance(0, 0, lx, ly);
var in_pocket = place_meeting(x, y, objQBPocket);

// --- ENTER AIM MODE ---
if (!pocket_aiming && pocket_cooldown == 0 && in_pocket && pull > pull_enter_threshold) {
    pocket_aiming = true;
    pocket_pulled = true;
    key_held = -1;
    key_hold_timer = 0;
}

// --- CANCEL with LB ---
if (pocket_aiming && gamepad_button_check_pressed(0, gp_shoulderl)) {
    pocket_aiming   = false;
    pocket_pulled   = false;
    pocket_cooldown = pocket_cooldown_frames;
    return false;
}

// --- Not aiming? Let regular QB logic run ---
if (!pocket_aiming) return false;

// --- Build and lock preview arc (while stick is still pulled back) ---
var hand_x = x + hand_offset_x;
var hand_y = y + hand_offset_y;

// Invert so pulling stick back throws farther!
var fx = (pull < 0.01) ? 1 : -lx;
var fy = (pull < 0.01) ? 0 : -ly;

var aim_dir   = point_direction(0, 0, fx, fy);
var aim_power = clamp(pull, 0, 1);

// Stick farther = longer throw!
var curve = power(aim_power, pull_curve_exponent);
var dist  = lerp(max_throw_distance, min_throw_distance, curve);  // Note: min/max order!
var arc_h = lerp(min_arc_height,     max_arc_height,     curve);

pocket_aim_dir   = aim_dir;
pocket_aim_power = aim_power;

// Recompute arc/target lock ONLY if stick is still back
if (pull >= pull_release_threshold)
{
    for (var i = 0; i < dot_count - 1; i++) {
        var t  = i / (dot_count - 1);
        var px = hand_x + lengthdir_x(dist * t, aim_dir);
        var py = hand_y + lengthdir_y(dist * t, aim_dir) - sin(pi * t) * arc_h;
        pocket_arc[i] = [px, py];
    }
    // End X
    var tx = hand_x + lengthdir_x(dist, aim_dir);
    var ty = hand_y + lengthdir_y(dist, aim_dir);
    pocket_arc[dot_count - 1] = [tx, ty];

    // Lock in for throw
    pocket_lock_dist  = dist;
    pocket_lock_arc_h = arc_h;
    pocket_lock_dir   = aim_dir;
    pocket_lock_tx    = tx;
    pocket_lock_ty    = ty;
}

// --- RELEASE STICK: PASS! ---
if (pocket_pulled && pull < pull_release_threshold) {
    var raw_spd = pocket_lock_dist / speed_divisor;
    var spd     = clamp(raw_spd, min_throw_speed, max_throw_speed);
    var ball_spd= min(spd, pocket_lock_dist - 1);

    with (objFootball)
    {
        pass_was_caught     = false;
        attached_to         = noone;
        play_active         = true;
        visible             = true;
        x                   = hand_x;
        y                   = hand_y;
        direction           = point_direction(
                                 x, y,
                                 other.pocket_lock_tx,
                                 other.pocket_lock_ty);
        speed               = ball_spd;
        target_x            = other.pocket_lock_tx;
        target_y            = other.pocket_lock_ty;
        var f = clamp(
                   other.pocket_lock_dist / speed,
                   min_flight_frames,
                   max_flight_frames);
        visual_arc_total    = f;
        visual_arc_peak     = other.pocket_lock_arc_h;
        visual_arc_time     = 0;
    }
    // QB state reset
    attached_to       = noone;
    can_throw         = false;
    throw_cooldown    = 5;
    pocket_cooldown   = pocket_cooldown_frames;
    pocket_aiming     = false;
    pocket_pulled     = false;
    return false;
}

// Still aiming—block the rest of QB logic
return true;
