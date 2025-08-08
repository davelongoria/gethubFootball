/// @desc objQB – Step Event (safe handoff logic, no variable errors)

if (global.game_paused) exit;

/* ─── Pocket passer override ─── */
if (scr_PocketPasser()) exit;

if x > objScrimmageMarker.x { is_running = true; }

visible = true;
depth   = -100;

/* ───────────────────────────────
   1. PRE-SNAP – QB stands behind LOS
─────────────────────────────── */
if (!hiked && attached_to == id)
{
    with (objFootball)
    {
        x           = objScrimmageMarker.x-75;
        y           = 616;
        visible     = true;
        attached_to = noone;
        speed       = 0;
        direction   = 0;
        global.play_active = false;
    }
    sprite_index = sprQbPresnap_gry;
}

/* ───────────────────────────────
   2. HIKE
─────────────────────────────── */
if (!hiked && global.qb_hike && can_throw)
{
    audio_stop_sound(sndHut);
    hiked              = true;
    ballHiked          = true;
    global.play_active = true;

    with (objFootball)
    {
        attached_to = other.id;
        visible     = false;
    }
    sprite_index = sprQBStandBallgry;
    audio_play_sound(sndHike, 5, false);
    audio_play_sound(sndCaught2, 1, false);

    if (global.play_is_run)
    {
        // Find nearest RB and set as handoff target; QB enters handoff mode (no player control)
        var nearest_rb = noone;
        var min_dist = 99999;
        with (objRunningBacks)
        {
            var dist = point_distance(other.x, other.y, x, y);
            if (dist < min_dist)
            {
                min_dist = dist;
                nearest_rb = id;
            }
        }
        if (nearest_rb != noone)
        {
            handoff_target = nearest_rb;
            is_handoff_mode = true;
        }
        else
        {
            handoff_target = noone;
            is_handoff_mode = false;
        }
    }
    else
    {
        handoff_target = noone;
        is_handoff_mode = false;
    }
}

/* ───────────────────────────────
   3-a. QB MOVEMENT (while holding ball)
─────────────────────────────── */
if (hiked && attached_to == id)
{
    var moved = false;

    // === RUNNING PLAY: Handoff mode (QB autopilot to RB) ===
    if (is_handoff_mode && handoff_target != noone && instance_exists(handoff_target))
    {
        var target = handoff_target;
        var dx = target.x - x;
        var dy = target.y - y;
        var dist = point_distance(x, y, target.x, target.y);
        var angle = point_direction(x, y, target.x, target.y);

        if (dist > 8) // Move toward RB until close
        {
            x += lengthdir_x(handoff_speed, angle);
            y += lengthdir_y(handoff_speed, angle);
            moved = true;
            image_xscale = (dx != 0) ? sign(dx) : image_xscale;
        }
        else
        {
            // COLLISION/HANDOFF!
            global.player_has_ball = handoff_target;
            attached_to = noone;
			audio_play_sound(sndCaught,0,false);

            with (objFootball)
            {
                attached_to = other.handoff_target; // Use QB's value safely!
                visible = false;
            }
            with (handoff_target)
            {
                attached_to = other.id; // QB's id
                hiked = true;
            }
            is_handoff_mode = false;
            handoff_target = noone;
        }
    }
    else
    {
        // === Normal QB control (only if not in handoff mode) ===
        if (abs(global.qb_move_x) > 0.1)
        {
            x += global.qb_move_x * 3;
            image_xscale = (global.qb_move_x < 0) ? -1 : image_xscale;
            moved = true;
        }
        if (abs(global.qb_move_y) > 0.1)
        {
            y += global.qb_move_y * 3;
            moved = true;
        }
    }

    sprite_index = moved
        ? sprRunWithBallgry
        : sprQBStandBallgry;
}

/* ───────────────────────────────
   3-b. QB BEHAVIOUR after he throws
─────────────────────────────── */
if (hiked && attached_to == noone && !playEnded)
{
    if (abs(global.qb_move_x) > 0.1 || abs(global.qb_move_y) > 0.1)
    {
        sprite_index = sprRunGry;           // running without ball
    }
    else
    {
        sprite_index = sprIdlegry;          // standing idle
    }
}

/* ───────────────────────────────
   4. CROSS LOS – disable passing
─────────────────────────────── */
if (x > objScrimmageMarker.x && can_throw) {
    can_throw = false;
}

/* ───────────────────────────────
   5. START THROW – begin charge
─────────────────────────────── */
if (hiked && can_throw && attached_to == id && global.throw_pressed != -1)
{
    var wr_list = [objWR1,objWR2,objWR3,objWR4,objWR5];
    selected_wr = instance_nearest(x, y, wr_list[global.throw_pressed]);

    key_held       = global.throw_pressed;
    key_hold_timer = 0;
    sprite_index   = sprQBThrowgry;
    audio_play_sound(choose(sndPass,sndThrow), 1, false);
}

/* ───────────────────────────────
   6. HOLD / RELEASE THROW
─────────────────────────────── */
if (key_held != -1)
{
    key_hold_timer++;

    var released = (global.throw_pressed == -1);   // input cleared
    if (released)
    {
        var ttype = (key_hold_timer < 10) ? "lob" : "bullet";
        var tpwr  = clamp((key_hold_timer/max_charge)*throw_power_base,
                          throw_power_base, max_throw_distance);
        tpwr = max(tpwr, 150);

        with (objFootball)
        {
            attached_to = noone;
            visible = true;
            throw_to_target(other.x + 32, other.y + 22,
                            other.selected_wr, tpwr, ttype);
        }

        can_throw      = false;
        attached_to    = noone;
        throw_cooldown = 5;
        key_held       = -1;
        key_hold_timer = 0;
    }
}

/* ───────────────────────────────
   7. KEEP BALL ON QB HAND (pre-throw)
─────────────────────────────── */
if (attached_to == id)
{
    with (objFootball)
    {
        x = other.x + 32;
        y = other.y + 22;
        visible = false;
    }
}

/* ───────────────────────────────
   8. END-OF-PLAY RESET (existing logic)
─────────────────────────────── */
if (playEnded)
{
    throw_cooldown--;
    if (attached_to == noone && !can_throw)
        sprite_index = sprIdlegry;

    if (throw_cooldown <= 0)
    {
        playEnded          = false;
        global.play_active = false;
        can_throw          = true;
        hiked              = false;
        ballHiked          = false;
        attached_to        = id;

        global.player_has_ball = noone;

        sprite_index = sprQbPresnap_gry;
        x = objScrimmageMarker.x - 75;
        y = 570;

        with (objFootball)
        {
            attached_to = noone;
            visible     = true;
            global.play_active = false;
            speed = 0; direction = 0;
            visual_arc_time  = 0;
            visual_arc_total = 0;
            visual_arc_peak  = 0;
            x = objScrimmageMarker.x;
            y = 616;
        }
        if !audio_is_playing(sndHut) { audio_play_sound(sndHut, 5, true); }
        // Reset handoff state for next play
        is_handoff_mode = false;
        handoff_target  = noone;
    }
}

/* ───────────────────────────────
   9. Helper for GUI (unchanged)
─────────────────────────────── */
throw_charge = key_hold_timer;
