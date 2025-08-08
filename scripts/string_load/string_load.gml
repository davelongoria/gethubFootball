/// string_load( path ) → contents
///
/// Reads the whole text-file at <path> into a single string.
/// Returns "" if the file cannot be opened.

function string_load(path)
{
    if (!file_exists(path))
        return "";

    var fh = file_text_open_read(path);
    var out = "";
    while (!file_text_eof(fh))
    {
        out += file_text_read_string(fh);
        file_text_readln(fh);            // consume line-ending
    }
    file_text_close(fh);
    return out;
}
