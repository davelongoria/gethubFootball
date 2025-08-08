/// scr_init_custom_content()
var dir_base = "data/custom/";
if (!directory_exists(dir_base))        directory_create(dir_base);
if (!directory_exists(dir_base + "logos"))   directory_create(dir_base + "logos");
if (!directory_exists(dir_base + "teams"))   directory_create(dir_base + "teams");
if (!directory_exists(dir_base + "rosters")) directory_create(dir_base + "rosters");
if (!directory_exists(dir_base + "palettes")) directory_create(dir_base + "palettes");
