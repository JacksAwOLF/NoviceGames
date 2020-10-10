/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
if (state == VisualState.inactive) exit;

draw_sprite_ext(sprite_index, success, x, y, image_xscale, image_yscale, 0, c_white, 1);

if (success_count > 0) {
	success_count -= 1;
	if (success_count == 0)
		success = 0;
}

