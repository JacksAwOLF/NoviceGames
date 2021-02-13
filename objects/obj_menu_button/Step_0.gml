/// @description Insert description here
// You can write your code in this editor


mouseIn = point_in_rectangle(mouse_x, mouse_y, x, y, x+width, y+height);

if (mouseIn){
	if (mouse_x <  midline) imgstate = 1;
	else imgstate = 2;
} else imgstate  = 0;
