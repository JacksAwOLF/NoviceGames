/// @description Insert description here
// You can write your code in this editor

if (state == VisualState.inactive) exit;

draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 0, c_white, 1);

if (sprite_index == spr_tile_border)
	draw_sprite_ext(spr_select_underMouse, 0, x, y, image_xscale, image_yscale, 0, c_white, 1);

if (get_soldier_type_from_sprite(sprite_index) != -1) {
	var width = image_xscale*sprite_get_width(sprite_index); 
	var height = image_yscale*sprite_get_height(sprite_index);
	var class = global.soldier_vars[Svars.class];
	
	draw_circle_color(x+width/4.5,y+height/3.75,width/8,global.colors[class],global.colors[class],false);
		
}
if (global.changeSprite == sprite_index)
	draw_sprite_ext(spr_select_possibleMove, 0, x, y, image_xscale, image_yscale, 0, c_white, 1);