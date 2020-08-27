/// @description Insert description here
// You can write your code in this editor


if ( point_in_rectangle(mouse_x, mouse_y,
x, y, x+sprite_width, y+sprite_height)){
	if (mouse_x <+mid_line) image_index = 1;
	else if (mouse_x < last_quarter_line) image_index = 2;
	else image_index = 3;
	
} else image_index = 0;