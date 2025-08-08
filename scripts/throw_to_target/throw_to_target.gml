/// @function throw_to_target(qb_x, qb_y, wr_inst, pow, pass_type)
/// @desc Predictive pass with distance-scaled arc & lead.
///       2025-06-22 21:45 CDT
///
/// Arguments:
/// 0  qb_x        – X position where ball leaves QB’s hand
/// 1  qb_y        – Y position where ball leaves QB’s hand
/// 2  wr_inst     – receiver instance
/// 3  pow         – raw charged power (≥150 enforced)
/// 4  pass_type   – "lob" or "bullet"

function throw_to_target(qb_x, qb_y, wr_inst, pow, pass_type)
{
    if (!instance_exists(wr_inst)) exit;

    /* ── clamp minimum power ── */
    if (pow < 150) pow = 150;

    /* ── receiver velocity (one-frame sample) ── */
    var wr_vx = 0;
    var wr_vy = 0;

    if (variable_instance_exists(wr_inst, "prev_x"))
    {
        wr_vx = wr_inst.x - wr_inst.prev_x;
        wr_vy = wr_inst.y - wr_inst.prev_y;
    }

    /* ── derive ball speed from power ── */
    var base_spd = (pass_type == "lob") ? 6 : 9;
    var ball_spd = clamp(pow / 25, base_spd, 18);   // 6 - 18 px/step

    /* ── distance & flight-time estimate ── */
    var dist     = point_distance(qb_x, qb_y, wr_inst.x, wr_inst.y);
    var time_est = clamp(dist / ball_spd, 6, 40);   // 0.1–0.67 s

    /* ── dynamic lead: short = small, long = large ── */
    var lead_fac = lerp(0.30, 0.75, time_est / 40.0);
    var lead_x   = wr_inst.x + wr_vx * lead_fac * time_est;
    var lead_y   = wr_inst.y + wr_vy * lead_fac * time_est;

    /* ── cap to max range (2200 px) ── */
    var max_rng  = 2200;
    var act_dist = point_distance(qb_x, qb_y, lead_x, lead_y);

    if (act_dist > max_rng)
    {
        var dir = point_direction(qb_x, qb_y, lead_x, lead_y);
        lead_x  = qb_x + lengthdir_x(max_rng, dir);
        lead_y  = qb_y + lengthdir_y(max_rng, dir);
        act_dist= max_rng;
        time_est= act_dist / ball_spd;
    }

    /* ── final heading ── */
    var dir_final = point_direction(qb_x, qb_y, lead_x, lead_y);

    /* ── configure the football ── */
    with (objFootball)
    {
        /* basic state */
        attached_to   = noone;
        play_active   = true;
        visible       = true;

        /* starting position */
        x = qb_x;
        y = qb_y;

        /* motion */
        direction     = dir_final;
        speed         = ball_spd;

        /* prediction target (for debug ring) */
        target_x      = lead_x;
        target_y      = lead_y;

        /* arc visuals: higher for longer throws */
        visual_arc_total = time_est;
        visual_arc_peak  = lerp(14, 30, time_est / 40.0);
        visual_arc_time  = 0;
    }
}
