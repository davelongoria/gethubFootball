/// scr_Hand_Off_To_RB(qb_instance)
var qb = argument0;

// Find the nearest RB to the QB
var nearest_rb = noone;
var min_dist = 99999;
with (objRunningBacks)
{
    var dist = point_distance(qb.x, qb.y, x, y);
    if (dist < min_dist)
    {
        min_dist = dist;
        nearest_rb = id;
    }
}

// If we found a running back, hand off!
if (nearest_rb != noone)
{
	
    global.player_has_ball = nearest_rb;
    with (qb) { attached_to = noone; }

    with (objFootball)
    {
        attached_to = nearest_rb;
        visible = false;
    }
    with (nearest_rb)
    {
        attached_to = id;
        hiked = true;
        // Optional: Update sprite here
        // sprite_index = sprRunWithBallgry;
    }
}
