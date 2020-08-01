/// @description Insert description here
// You can write your code in this editor


draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 0, c_white, 1);

if (global.changeSprite[what] == sprite_index)
	draw_sprite_ext(spr_select_possibleMove, 0, x, y, image_xscale, image_yscale, 0, c_white, 1);