
/// objTeamController – Step  (original code + “CPU-pick” toggle)
//--------------------------------------------------------------
var team_ct = array_length(teams);
function wrap_up(i){ return (i - 1 + team_ct) mod team_ct; }
function wrap_dn(i){ return (i + 1)        mod team_ct; }

// -------------------------------------------------------------

//--------------------------------------------------------------
// 1. Game-pad / keyboard input  (P1 = pad-0 / KB)
//--------------------------------------------------------------
var ax = gamepad_axis_value(0, gp_axislh);
var ay = gamepad_axis_value(0, gp_axislv);

var tap_thr = 0.85;
var p1_left  =  ax < -tap_thr && prev_ax > -tap_thr;
var p1_right =  ax >  tap_thr && prev_ax <  tap_thr;
var p1_up    =  ay < -tap_thr && prev_ay > -tap_thr;
var p1_down  =  ay >  tap_thr && prev_ay <  tap_thr;

prev_ax = ax; prev_ay = ay;

p1_left  |= keyboard_check_pressed(ord("A"));
p1_right |= keyboard_check_pressed(ord("D"));
p1_up    |= keyboard_check_pressed(vk_up);
p1_down  |= keyboard_check_pressed(vk_down);

// -------- NEW ----------
//  left-stick button  ( “L3” = gp_lstick )  toggles CPU-pick mode
//  keyboard mirror: key C
var l3_pressed = gamepad_button_check_pressed(0, gp_stickl) || keyboard_check_pressed(ord("C"));
if (l3_pressed)
{
    cpu_pick_mode = !cpu_pick_mode;
    if (have_sndSelect) audio_play_sound(sndSelect,0,false);
}
// -----------------------

//--------------------------------------------------------------
// 2. Swap sides (unchanged)
//--------------------------------------------------------------
if (p1_left || p1_right)
{
    p1.side ^= 1;
    cpu_or_p2.side ^= 1;

    p1.x        = xs[p1.side];
    cpu_or_p2.x = xs[cpu_or_p2.side];

    var t       = home_index;
    home_index  = away_index;
    away_index  = t;

    if (have_sndSelect) audio_play_sound(sndSelect, 0, false);
}

//--------------------------------------------------------------
// 3. Scroll teams
//    • when cpu_pick_mode = false → works exactly as before
//    • when cpu_pick_mode = true  → P1’s ↑↓ always move the CPU / away team
//--------------------------------------------------------------
if (!cpu_pick_mode)
{
    // normal behaviour
    if (p1.side == 0) {
        if (p1_up)   home_index = wrap_up(home_index);
        if (p1_down) home_index = wrap_dn(home_index);
    } else {
        if (p1_up)   away_index = wrap_up(away_index);
        if (p1_down) away_index = wrap_dn(away_index);
    }
}
else
{
    // CPU-pick mode  →  P1’s stick scrolls the *away* column
    if (p1_up)   away_index = wrap_up(away_index);
    if (p1_down) away_index = wrap_dn(away_index);

    // safety: keep distinct
    if (away_index == home_index) away_index = wrap_dn(away_index);
}

/*  (optional distinct-enforcer kept commented exactly as you had)
if (home_index == away_index)
{
    away_index = wrap_dn(away_index);
}
*/

//--------------------------------------------------------------
// 4. Pad-1 joins / times-out  (unchanged)
//--------------------------------------------------------------
var p2_start = gamepad_button_check_pressed(1, gp_start);

if (!p2_is_human && p2_start)
{
    p2_is_human             = true;
    cpu_or_p2.sprite_index   = sprP2;
    cpu_or_p2.is_cpu         = false;
    p2_idle_ctr              = 0;
    if (have_sndPress) audio_play_sound(sndPressed,0,false);
}
else if (p2_is_human)
{
    var any_btn =
        p2_start ||
        abs(gamepad_axis_value(1,gp_axislv)) > 0.2 ||
        abs(gamepad_axis_value(1,gp_axislh)) > 0.2;

    if (any_btn) p2_idle_ctr = 0; else p2_idle_ctr++;

    if (p2_idle_ctr > cpu_idle_steps)
    {
        p2_is_human             = false;
        cpu_or_p2.sprite_index   = sprCPU;
        cpu_or_p2.is_cpu         = true;
        p2_idle_ctr              = 0;
    }

    // player-2 scrolls only its own column
    var ax1 = gamepad_axis_value(1, gp_axislh);
    var ay1 = gamepad_axis_value(1, gp_axislv);
    if (is_undefined(prev_ax1)){ prev_ax1 = ax1; prev_ay1 = ay1; }

    var p2_up   =  ay1 < -tap_thr && prev_ay1 > -tap_thr;
    var p2_down =  ay1 >  tap_thr && prev_ay1 <  tap_thr;

    if (p2_up)   away_index = wrap_up(away_index);
    if (p2_down) away_index = wrap_dn(away_index);
    if (away_index == home_index) away_index = wrap_dn(away_index);

    prev_ax1 = ax1; prev_ay1 = ay1;
}

