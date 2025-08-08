/// objTeamController – Step
// ------------------------------------------------------------
// P1  : keyboard  (A,D,W,S  or  ↑↓←→)  + Pad-0 left stick
// CPU : scroll with P1-stick when cpu_pick_mode = true
// P2  : Pad-1 joins on START   (unchanged)
// ------------------------------------------------------------

var team_ct = array_length(teams);
function wrap_up(i){ return (i - 1 + team_ct) mod team_ct; }
function wrap_dn(i){ return (i + 1)        mod team_ct; }

// ----------------------------------------------------------------
// 1.  Pad-0 / keyboard input (P1)
// ----------------------------------------------------------------
var ax = gamepad_axis_value(0, gp_axislh);
var ay = gamepad_axis_value(0, gp_axislv);

var tap_thr  = 0.85;
var p1_left  =  ax < -tap_thr && prev_ax > -tap_thr;
var p1_right =  ax >  tap_thr && prev_ax <  tap_thr;
var p1_up    =  ay < -tap_thr && prev_ay > -tap_thr;
var p1_down  =  ay >  tap_thr && prev_ay <  tap_thr;

prev_ax = ax;  prev_ay = ay;

// keyboard mirrors (optional)
p1_left  |= keyboard_check_pressed(ord("A"));
p1_right |= keyboard_check_pressed(ord("D"));
p1_up    |= keyboard_check_pressed(vk_up);
p1_down  |= keyboard_check_pressed(vk_down);

// ── Toggle CPU-pick mode (L-stick button or key C) ────────────
var l3_pressed =
      gamepad_button_check_pressed(0, gp_stickl)
  ||  keyboard_check_pressed(ord("C"));

if (l3_pressed)
{
    cpu_pick_mode = !cpu_pick_mode;
    if (have_sndSelect) audio_play_sound(sndSelect, 0, false);
}

// ----------------------------------------------------------------
// 2.  Swap HOME / AWAY sides (unchanged)
// ----------------------------------------------------------------
if (p1_left || p1_right)
{
    p1.side        ^= 1;
    cpu_or_p2.side ^= 1;

    p1.x        = xs[p1.side];
    cpu_or_p2.x = xs[cpu_or_p2.side];

    var t       = home_index;
    home_index  = away_index;
    away_index  = t;

    if (have_sndSelect) audio_play_sound(sndSelect, 0, false);
}

// ----------------------------------------------------------------
// 3.  Scroll teams
// ----------------------------------------------------------------
if (!cpu_pick_mode)
{
    // ── NORMAL mode ──  P1 scrolls his own column
    if (p1.side == 0) {
        if (p1_up)   home_index = wrap_up(home_index);
        if (p1_down) home_index = wrap_dn(home_index);
    }
    else {
        if (p1_up)   away_index = wrap_up(away_index);
        if (p1_down) away_index = wrap_dn(away_index);
    }
}
else
{
    // ── CPU-PICK mode ──  P1 always scrolls the column
    // the CPU (or future P2) is currently occupying.
    var cpu_side = cpu_or_p2.side;   // 0 = HOME, 1 = AWAY

    if (cpu_side == 0)
    {
        if (p1_up)   home_index = wrap_up(home_index);
        if (p1_down) home_index = wrap_dn(home_index);

        if (home_index == away_index)
            home_index = wrap_dn(home_index);
    }
    else
    {
        if (p1_up)   away_index = wrap_up(away_index);
        if (p1_down) away_index = wrap_dn(away_index);

        if (away_index == home_index)
            away_index = wrap_dn(away_index);
    }
}

/*  (If you still want the always-distinct safeguard, uncomment)
if (home_index == away_index)
    away_index = wrap_dn(away_index);
*/

// ----------------------------------------------------------------
// 4.  Pad-1 joins or times-out  (original logic)
// ----------------------------------------------------------------
var p2_start = gamepad_button_check_pressed(1, gp_start);

if (!p2_is_human && p2_start)
{
    p2_is_human           = true;
    cpu_or_p2.sprite_index = sprP2;
    cpu_or_p2.is_cpu       = false;
    p2_idle_ctr            = 0;
    if (have_sndPress) audio_play_sound(sndPressed, 0, false);
}
else if (p2_is_human)
{
    var any_btn =
        p2_start ||
        abs(gamepad_axis_value(1, gp_axislv)) > 0.2 ||
        abs(gamepad_axis_value(1, gp_axislh)) > 0.2;

    if (any_btn) p2_idle_ctr = 0; else p2_idle_ctr++;

    if (p2_idle_ctr > cpu_idle_steps)
    {
        p2_is_human           = false;
        cpu_or_p2.sprite_index = sprCPU;
        cpu_or_p2.is_cpu       = true;
        p2_idle_ctr            = 0;
    }

    // player-2 (if human) scrolls only its own column
    var ax1 = gamepad_axis_value(1, gp_axislh);
    var ay1 = gamepad_axis_value(1, gp_axislv);
    if (is_undefined(prev_ax1)){ prev_ax1 = ax1; prev_ay1 = ay1; }

    var p2_up   = ay1 < -tap_thr && prev_ay1 > -tap_thr;
    var p2_down = ay1 >  tap_thr && prev_ay1 <  tap_thr;

    if (p2_up)   away_index = wrap_up(away_index);
    if (p2_down) away_index = wrap_dn(away_index);
    if (away_index == home_index) away_index = wrap_dn(away_index);

    prev_ax1 = ax1;  prev_ay1 = ay1;
}

// ----------------------------------------------------------------
// 5.  (Optional palette / helmet previews)
// ----------------------------------------------------------------
scr_palette_init( teams[home_index] );   // HOME preview
scr_palette_init_away ( teams[away_index] );   // away surface
