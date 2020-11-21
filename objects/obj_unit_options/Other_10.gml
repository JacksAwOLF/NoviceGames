/// @description Insert description here
// You can write your code in this editor

var yindex = floor((mouse_y - y) / (74 * image_yscale));
if (yindex < array_length(unit_options))
	unit_options[yindex].execute();