function scr_show_roster_editor(roster_array) {
    global.roster_editor_data = array_create(array_length(roster_array), 0);
    array_copy(global.roster_editor_data, 0, roster_array, 0, array_length(roster_array));
}
