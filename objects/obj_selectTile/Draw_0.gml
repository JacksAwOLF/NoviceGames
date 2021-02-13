/// @description Insert description here
// You can write your code in this editor

if (state == VisualState.inactive) exit;

draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 0, c_white, 1);

if (sprite_index == spr_tile_border)
	draw_sprite_ext(spr_select_underMouse, 0, x, y, image_xscale, image_yscale, 0, c_white, 1);


// if units are melee, ranged, or scouts, draw colored circle
if (description == "units" && global.soldier_vars[Svars.unit_page] < 3) {
	
	var width = image_xscale*sprite_get_width(sprite_index); 
	var height = image_yscale*sprite_get_height(sprite_index);
	var class = global.soldier_vars[Svars.unit_page];
	
	draw_circle_color(x+width/4.5,y+height/3.75,width/8,global.colors[class],global.colors[class],false);
}

if (global.changeSprite == sprite_index)
	draw_sprite_ext(spr_select_possibleMove, 0, x, y, image_xscale, image_yscale, 0, c_white, 1);
