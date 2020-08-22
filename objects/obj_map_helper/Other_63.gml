/// @description Insert description here
// You can write your code in this editor

var i_d = ds_map_find_value(async_load, "id");
var val = ds_map_find_value(async_load, "result");


if (ds_map_find_value(async_load, "status") <= 0 && i_d != move) //apparantly empty inpput counts as status<=0
	room_goto(rm_start_screen);	
else if i_d == hor  {
	hor = real(val);
	ver = get_integer_async("How many tiles top to botton? ", 5);
} else if i_d == ver {
	ver = real(val);
	
	global.mapHeight = ver
	global.mapWidth = hor
	
	load_map_from_file("");
} 

else if i_d == load_file {
	load_map_from_file(string(val));
	
	// determine if we should move, or wait for oponnent
	if (global.action != "laod")
		if (global.action == "playw" && global.turn%2==1 || 
		global.action == "playb" && global.turn%2==0){
			next_move(); // can't let "black" see "white's" fog of war if the loaded map is "white's" turn
			get_text();
		}
}


else if i_d == move {
	// execute the opponents moves
	next_move();   // go to opponents turn
	val = string(val);
	if (val != "") set_text();
	next_move();    // back to my turn
}

