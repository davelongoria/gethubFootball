// --- Camera Controller: Zoom & Follow for Pocket Passer ---

// Match your view size
cam_base_width  = 960;
cam_base_height = 540;

// Camera zoom factors
zoom_default    = 1.0;   // 1.0 = normal
zoom_pocket     = 1.4;   // >1.0 = zoomed out, <1.0 = zoomed in

// How quickly camera zooms/pans
zoom_lerp_speed = 0.09;
pan_lerp_speed  = 0.13;

// State vars (do not change)
cam_target_zoom = zoom_default;
cam_current_zoom= zoom_default;

cam_target_x = 0;
cam_target_y = 0;
cam_current_x = 0;
cam_current_y = 0;
