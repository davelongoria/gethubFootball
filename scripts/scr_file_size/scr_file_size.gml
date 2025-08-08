
/// scr_file_size(path) – returns length in bytes
function scr_file_size(_path)
{
    var fh   = file_bin_open(_path, fb_read);
    var size = file_bin_size(fh);
    file_bin_close(fh);
    return size;
}