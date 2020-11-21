/// @description Insert description here
// You can write your code in this editor

// had to override clickable inherited event because
// we needed to expand click detection when the dropdown is active

// Inherit the parent event
if (keyboard_check_pressed(hide_key)) 
	toggle_active();


var mouseIn = mouse_x > x && mouse_x < x+sprite_width &&
			  mouse_y > y && mouse_y < y+sprite_height;

if (mouseIn && (global.mouseInstanceId == -1 || global.mouseInstanceId.depth > depth)) {
	
	var eventId = -1;
	
	if (mouse_check_button_pressed(mb_left)) eventId = 0;
	else if (mouse_check_button(mb_left)) eventId = 1;
	else if (mouse_check_button_released(mb_left)) eventId = 2;
	// eventId 3: double click
	else if (mouse_check_button_released(mb_right)) eventId = 4;
	
	if (eventId >= 0) {
		global.mouseEventId = eventId;
		global.mouseInstanceId = id;
	}
	
}
