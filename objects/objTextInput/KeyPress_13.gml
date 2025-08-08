/// objTextInput – Key Press Enter
if (target_index != -1 && target_field != "") {
    var player = global.roster_editor_data[target_index];
    player[target_field] = text;
    global.roster_editor_data[target_index] = player;
}
instance_destroy();
