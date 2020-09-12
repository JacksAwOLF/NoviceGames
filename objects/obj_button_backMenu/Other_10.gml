/// @description Insert description here
// You can write your code in this editor

if (client_connected() == 1) exit;


if (instance_exists(obj_server)){
	//debug("clicked and destroyed")
	instance_destroy(instance_find(obj_server, 0));
}
	
room_goto(rm_start_screen)