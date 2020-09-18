/// @description Insert description here
// You can write your code in this editor

var i_d = ds_map_find_value(async_load, "id");
var val = ds_map_find_value(async_load, "result");

if global.map_loaded exit;

if (ds_map_find_value(async_load, "status") <= 0 && i_d != move) //apparantly empty inpput counts as status<=0
	room_goto(rm_start_screen);	
	
	
else if i_d == hor  {
	hor = real(val);
	ver = get_integer_async("How many tiles top to botton? ", 5);
} else if i_d == ver{
	ver = real(val);
	
	global.mapHeight = ver
	global.mapWidth = hor
	
	init_map(Mediums.file); // ignore warning
} 

else if i_d == load_file {

	init_map(Mediums.file, string(val));
	
	if global.action == "server"
		instance_create_depth(x, y, 0, obj_server)
}

