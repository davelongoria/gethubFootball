/// string_save( path , str )
///
/// Writes <str> out to <path>, overwriting if it exists.

function string_save(path, str)
{
    var fh = file_text_open_write(path);
    file_text_write_string(fh, str);
    file_text_close(fh);
}
