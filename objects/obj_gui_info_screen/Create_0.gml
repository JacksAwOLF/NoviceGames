/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

hide_key = ord("I");

mouse_xstart = -1;
mouse_ystart = -1;

current_camera = view_get_camera(0);

is_selected = false;	// variable to make sure we click detection stays on this object when dragging
is_moving = false;		// variable to prevent object from moving even during regular clickss