function scr_get_ballcarrier() {
	
    var carrier = noone;

    with (objWRParent) {
        if (hasBall) {
            carrier = id;
            break;
        }
    }

    if (carrier == noone && instance_exists(objFootball)) {
        if (objFootball.attached_to != noone && instance_exists(objFootball.attached_to)) {
            carrier = objFootball.attached_to;
        }
    }

    return carrier;
}
