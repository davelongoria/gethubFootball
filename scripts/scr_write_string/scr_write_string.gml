/// scr_write_string( path , txt )  ▸ writes whole file (over-write)
function scr_write_string(p, t)
{
    var fh = file_text_open_write(p);
    file_text_write_string(fh, t);
    file_text_close(fh);
}
