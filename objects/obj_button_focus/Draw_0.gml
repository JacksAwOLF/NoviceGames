/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
if (state == VisualState.inactive) exit;

draw_sprite(sprite_index, success, x, y);

if (success_count > 0) {
	success_count -= 1;
	if (success_count == 0)
		success = 0;
}

