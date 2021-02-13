/// @description Insert description here
// You can write your code in this editor
switch(floor(imgstate)){
	case 1:
		global.action = "server";
		global.playas = 0;
		break;
	case 3:
		global.action = "server";
		global.playas = 1;
		break;
	case 2:
		global.action = "client";
		break;
}

room_goto(rm_map)
