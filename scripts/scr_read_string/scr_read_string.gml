/// scr_read_string( path )  ▸ returns whole file
function scr_read_string(p)
{
    if (!file_exists(p)) return "";
    var fh = file_text_open_read(p), s = "";
    while (!file_text_eof(fh))
    {
        s += file_text_read_string(fh);
        if (!file_text_eof(fh)) file_text_readln(fh);
    }
    file_text_close(fh);
    return s;
}

