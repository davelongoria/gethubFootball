// Clean up the surface if it was used in this object
if (surface_exists(rmtr_surface)) {
	surface_free(rmtr_surface);	
}

if (surface_exists(rmtr_surface_2)) {
	surface_free(rmtr_surface_2);	
}

if (surface_exists(rmtr_surface_3)) {
	surface_free(rmtr_surface_3);	
}

// Delete the sprite if it was used for this object
if (sprite_exists(rmtr_surface_sprite)) {
	sprite_delete(rmtr_surface_sprite);	
}
