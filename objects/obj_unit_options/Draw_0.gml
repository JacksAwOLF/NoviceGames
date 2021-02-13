/// @description Insert description here
// You can write your code in this editor

if (state == VisualState.inactive) exit;

draw_self();	
for (var i = 0; i < array_length(unit_options); i++) 
	draw_sprite_ext(unit_options[i].sprite, 0, x+(sprite_width-image_xscale*64)/2, y+image_yscale*(10+i*64), image_xscale, image_yscale, 0, c_white, 1);
