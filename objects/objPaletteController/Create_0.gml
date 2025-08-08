persistent = true;
global.palette_needs_refresh = false;

// Init palette surface
scr_palette_init(); // your existing setup

shd      = shdPaletteTex;
uni_pal  = shader_get_sampler_index(shd,"u_pal");
