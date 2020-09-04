/// @description Insert description here
// You can write your code in this editor

var n = selected_dropdown == -1 ? instance_number(obj_sprite_dropdown) : 
	array_length(selected_dropdown.options);


for (var i=0; i<n; i++)
	if ( keyboard_check_pressed(( ord(string(i+1)) )) ){
		
		if (selected_dropdown == -1){
			selected_dropdown = instance_find(obj_sprite_dropdown, i);
			selected_dropdown.dropdown_active = true;
		} else {
			selected_dropdown.options_id = i;
			with(selected_dropdown) event_user(15);
			selected_dropdown = -1;
		}
		
		break;
	}
	
	