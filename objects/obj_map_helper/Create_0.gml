/// @description Insert description here
// You can write your code in this editor

hor = -1
ver = -1
load_file = -1

global.map_loaded = false
move = -1;


switch(global.action){
	case "client":
		instance_create_depth(x, y, 0, obj_server);	
		break;
		
	case "server": case "load": 
		load_file = get_string_async("Enter file name: ", "hi.txt");
		break;
		
	case "new":
		hor = get_integer_async("How many empty tiles left to right?", 10);
		break;
	default:
		show_error("ugh", true);
}



selected_dropdown = -1;
