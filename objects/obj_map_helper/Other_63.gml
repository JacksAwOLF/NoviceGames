/// @description Insert description here
// You can write your code in this editor

var i_d = ds_map_find_value(async_load, "id");
var val = ds_map_find_value(async_load, "result");

if map_loaded exit;

if (ds_map_find_value(async_load, "status") <= 0 && i_d != move) //apparantly empty inpput counts as status<=0
	room_goto(rm_start_screen);	
else if i_d == hor  {
	hor = real(val);
	ver = get_integer_async("How many tiles top to botton? ", 5);
} else if i_d == ver{
	ver = real(val);
	
	global.mapHeight = ver
	global.mapWidth = hor
	
	load_map_from_file("");
} 

else if i_d == load_file {
	load_map_from_file(string(val));
	
	if (!global.edit){
		// set up server/client
		global.port = 3690;
		global.serverurl = "127.0.0.1";
		instance_create_depth(x, y, 0, obj_server);	
	
	
		// determine if we should move, or wait for oponnent
		if (global.action != "load" && !network_my_turn()){
		
			// change the fog to your view
			global.turn += 1;
			update_fog();
			global.turn -= 1;
		
		
		}
	}
			
}


/*else if i_d == move {
	// execute the opponents moves
	next_move();   // go to opponents turn
	val = string(val);
	if (val != "") set_text();
	next_move();    // back to my turn
}*/

