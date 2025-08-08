/// scr_write_text(path, text)
/*
    Writes a string to disk inside the sandbox.
    Returns true on success, false on failure.
*/
function scr_write_text(path, text)
{
    var file = file_text_open_write(path);
    if (file == -1)
    {
        show_debug_message("scr_write_text — COULDN'T OPEN: " + path);
        return false;
    }

    file_text_write_string(file, text);
    file_text_close(file);
    return true;
}
