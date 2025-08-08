// objPauseMenu - Create Event
audio_pause_all();

menu_buttons = ["Toggle Fullscreen", "Main Menu", "Exit to Desktop"];
selected = 0;
hovered = -1;
just_unpaused = false;

fade = 0; // 0 = transparent, 1 = fully visible
fade_speed = 0.15; // adjust for desired fade speed
fading_out = false;
fade_wait = false; // locks input during fade-out

global.game_paused = true;

// For sound tracking
_prev_selected = selected;
_prev_hovered = hovered;
