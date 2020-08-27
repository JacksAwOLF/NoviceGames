/// @description Insert description here
// You can write your code in this editor
switch(floor(image_index)){
	case 1:
		global.action = "load";
		break;
	case 2:
		global.action = "playw";
		break;
	case 3:
		global.action = "playb";
		break;
	default:		
		show_error("ugh "+string(image_index), true);
}

room_goto(rm_map)