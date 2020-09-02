/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
if (state == VisualState.inactive) exit;
draw_sprite_ext(sprite_index, dropdown_active, x, y, image_xscale, image_yscale, 0, c_white, 1);



if (dropdown_active) {

	draw_set_color($FF99CC);
	draw_roundrect_ext(x, y+sprite_height, x+sprite_width, y+sprite_height+menu_height*image_yscale, 
						10*image_xscale, 10*image_yscale, 0);
	
	menu_height = 0;
	for (var i = 0; i < array_length_1d(options); i++) {
		draw_sprite_ext(options[i], 0, x, y+sprite_height+menu_height*image_yscale, image_xscale, image_yscale, 0, c_white, 1);
		menu_height += sprite_get_height(options[i]);
	}
	
	draw_set_color(c_black);
}