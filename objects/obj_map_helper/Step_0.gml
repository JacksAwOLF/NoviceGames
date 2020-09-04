/// @description Insert description here
// You can write your code in this editor

//var n = selected_dropdown == -1 ? instance_number(obj_sprite_dropdown) : 
//	array_length(selected_dropdown.options);


for (var i=0; i<10; i++)
	if ( keyboard_check_pressed(( ord(string(i+1)) )) ){
		
		var skip = false;
		
		if (selected_dropdown == -1 && i+1 <= instance_number(obj_sprite_dropdown)){
			selected_dropdown = instance_find(obj_sprite_dropdown, i);
			selected_dropdown.dropdown_active = true;
			if (array_length(selected_dropdown.options) > 1) skip = true;
		} 
		
		if (!skip && selected_dropdown !=-1) {
			selected_dropdown.options_id = i;
			with(selected_dropdown) event_user(15);
			selected_dropdown = -1;
		}
		
		break;
	}
	
	
if (map_loaded && global.edit && keyboard_check_pressed(( ord("0") ) ) ){
	if (selected_dropdown) selected_dropdown.dropdown_active = false;
	selected_dropdown = -1;
	global.changeSprite = -1;
}