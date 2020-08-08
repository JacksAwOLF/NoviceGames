/// @description Insert description here
// You can write your code in this editor

var i_d = ds_map_find_value(async_load, "id");



if !ds_map_find_value(async_load, "status")  {
	room_goto(rm_start_screen);	
}
else if i_d == hor  {
	hor = real(ds_map_find_value(async_load, "result"));
	ver = get_integer_async("How many tiles top to botton? ", 5);
}

else if i_d == ver {
	ver = real(ds_map_find_value(async_load, "result"));
	
	global.mapHeight = ver
	global.mapWidth = hor
	
	load_map_from_file("");
}


else if i_d == load_file {
	load_map_from_file(string(ds_map_find_value(async_load, "result")));
}


