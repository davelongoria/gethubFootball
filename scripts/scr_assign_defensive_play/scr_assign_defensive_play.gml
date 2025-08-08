function scr_assign_defensive_play(play_id) {

    switch (play_id) {

        case "cover_2":
            with (obj_cornerback) {
                role = "zone";
                zone_x = objFootball.x;
                zone_y = objFootball.y - 200; // Deep zones
                zone_radius = 150;
            }
            with (obj_safety) {
                role = "zone";
                zone_x = objFootball.x;
                zone_y = objFootball.y - 250;
                zone_radius = 200;
            }
            with (obj_linebacker) {
                role = "zone";
                zone_x = objFootball.x;
                zone_y = objFootball.y - 100; // Shallow zone
                zone_radius = 120;
            }
            break;
         case "prevent":
          
			with (obj_cornerback) {
                role = "zone";
                zone_x = objFootball.x;
                zone_y = objFootball.y - 200; // Deep zones
                zone_radius = 150;
            }
			
            with (obj_linebacker) {
                role = "zone";
                zone_x = objFootball.x;
                zone_y = objFootball.y - 100; // Shallow zone
                zone_radius = 120;
            }
            break;
        case "blitz_a":
            with (obj_linebacker) {
                role = "blitz";
            }
            with (obj_cornerback) {
                role = "man";
                target_player = instance_find(objWRParent, 0); // Example: covering WRs
            }
            with (obj_safety) {
                role = "zone";
                zone_x = objFootball.x;
                zone_y = objFootball.y - 250;
                zone_radius = 180;
            }
            break;

        case "qb_spy":
            with (obj_linebacker) {
                role = "spy";
            }
            with (obj_cornerback) {
                role = "man";
                target_player = instance_find(objWRParent, 0);
            }
            break;
			
    }

    // Set reaction timer for all defenders
    with (obj_defender) {
        alarm[0] = reaction_time * room_speed;
        state = "idle";
    }
}
