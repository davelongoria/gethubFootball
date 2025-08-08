/// MENU SELECT HANDLER (User Event 0)
if (sndMenuSelect != noone) audio_play_sound(sndMenuSelect, 1, false);
switch (selected) {
    case 0: room_goto(rmQuickPlay); show_debug_message("[MENU] SELECT: Quick Play"); break;
    case 1: show_debug_message("[MENU] SELECT: Online Play"); break;
    case 2: room_goto(rmFranchise); show_debug_message("[MENU] SELECT: Franchise"); break;
    case 3: room_goto(rmCreateTeam); show_debug_message("[MENU] SELECT: Create Team"); break;
    case 4: show_debug_message("[MENU] SELECT: Edit Team: " + teams[edit_team_index]); break;
    case 5: room_goto(rmSettings); show_debug_message("[MENU] SELECT: Settings"); break;
    case 6: game_end(); show_debug_message("[MENU] SELECT: Exit"); break;
}
