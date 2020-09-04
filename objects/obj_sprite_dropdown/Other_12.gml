/// @description Insert description here
// You can write your code in this editor

if (dropdown_active && point_in_rectangle(mouse_x,mouse_y,x,y+sprite_height,x+sprite_width,y+sprite_height+menu_height*image_yscale)) {
	options_id = 0;
	var cur_height = y+sprite_height;
	while (options_id < array_length_1d(options)) {
		cur_height += sprite_get_height(options[options_id])*image_yscale;
		
		if (cur_height >= mouse_y) break;
		options_id++;
	}
	
	
	event_user(15);
} 

else dropdown_active = !dropdown_active;

if (dropdown_active)
	instance_find(obj_map_helper, 0).selected_dropdown = id;