/// @description Insert description here
// You can write your code in this editor

// direrence
var size = global.grid[pos].size;
var mouseIn = point_in_rectangle(mouse_x,mouse_y,x,y,x+size,y+size);
// difference end

if (mouseIn && (global.mouseInstanceId == -1 || global.mouseInstanceId.depth > depth)) {
	
	var eventId = -1;
	
	if (mouse_check_button_pressed(mb_left)) eventId = 0;
	else if (mouse_check_button(mb_left)) eventId = 1;
	else if (mouse_check_button_released(mb_left)) eventId = 2;
	
	if (eventId >= 0) {
		global.mouseEventId = eventId;
		global.mouseInstanceId = id;
	}
	
}