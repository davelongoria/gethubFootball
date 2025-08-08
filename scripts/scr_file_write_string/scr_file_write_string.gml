/// scr_file_write_string(path, text)
///
/// Reliable helper that writes a full string to disk.
/// Returns true on success, false on failure.

function scr_file_write_string(_path, _text)
{
    var h = file_text_open_write(_path);
    if (h < 0) return false;

    file_text_write_string(h, string(_text));
    file_text_close(h);
    return true;
}
