/// objTextInput – Global Key Press Event
var key_str = keyboard_string;
if (string_length(key_str) > 0) {
    var new_char = string_copy(key_str, string_length(key_str), 1);
    if (string_length(text) < 16) { // limit to 16 chars
        text += new_char;
    }
}
