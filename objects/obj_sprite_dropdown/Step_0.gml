/// @description Insert description here
// You can write your code in this editor


var prev_state = dropdown_active;

	
// Inherit the parent event
event_inherited();

// if mouse is pressed again after menu was open
// close the dropdown menu
if (mouse_check_button_released(mb_left) && prev_state){
	dropdown_active = false;
	instance_find(obj_map_helper, 0).selected_dropdown = -1;
}