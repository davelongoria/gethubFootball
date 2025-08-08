// --- Smooth Camera Zoom & Pan based on Pocket Passer ---

// Who to follow? QB if aiming, else football
var follow_x, follow_y;

if (instance_exists(objQB) && objQB.pocket_aiming) {
    cam_target_zoom = zoom_pocket; // Zoom OUT!
    follow_x = objQB.x + 32;
    follow_y = objQB.y + 22;
} else if (instance_exists(objFootball)) {
    cam_target_zoom = zoom_default;
    follow_x = objFootball.x;
    follow_y = objFootball.y;
} else {
    cam_target_zoom = zoom_default;
    follow_x = cam_base_width / 2;
    follow_y = cam_base_height / 2;
}

// --- Smoothly lerp zoom ---
cam_current_zoom = lerp(cam_current_zoom, cam_target_zoom, zoom_lerp_speed);

// --- Calculate camera position centered on target ---
cam_target_x = follow_x - (cam_base_width  * 0.5) * cam_current_zoom;
cam_target_y = follow_y - (cam_base_height * 0.5) * cam_current_zoom;

// Clamp so camera doesn't go out of bounds
cam_target_x = clamp(cam_target_x, 0, room_width  - cam_base_width  * cam_current_zoom);
cam_target_y = clamp(cam_target_y, 0, room_height - cam_base_height * cam_current_zoom);

// --- Smoothly lerp pan ---
cam_current_x = lerp(cam_current_x, cam_target_x, pan_lerp_speed);
cam_current_y = lerp(cam_current_y, cam_target_y, pan_lerp_speed);

// --- Apply to view/camera ---
camera_set_view_pos(view_camera[0], cam_current_x, cam_current_y);
camera_set_view_size(view_camera[0], cam_base_width  * cam_current_zoom, cam_base_height * cam_current_zoom);
