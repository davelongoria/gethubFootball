
global.play_active = false;
global.qb_hike = false;
global.qb_move_x = 0;
global.qb_move_y = 0;
global.throw_pressed = -1;
global.player_has_ball = noone;
// Initialize touchdown flag
global.touchdown_scored = false;
global.celebration_active = false;
global.celebration_timer = 0;
//global.touchdown_scored      = false;
global.shared_celebrate_sent = false;
/// which side a player belongs to:  "offense" or "defense"
global.TEAM_OFFENSE = "offense";
global.TEAM_DEFENSE = "defense";

global.score_home = 0;
global.score_away = 0;

global.last_scrimmage_x = 964
global.last_scrimmage_y  = 400
global.path_assign_mode = false;
global.path_wr_index = -1;
global.path_selected = "";
global.logos_dir = "logos/";
global.game_paused = false;
//global.current_edit_team = 0;   // which team we’re editing right now
global.font = font_add_sprite(spr_font_3,48,true,true)
global.play_is_run = false;

global.interception = false;
global.roster_editor_active = false;
