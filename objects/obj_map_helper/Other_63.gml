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
	
	init_map(Mediums.file); // ignore warning
	map_loaded = true;
} 

else if i_d == load_file {
	
	/*if global.action == "server"{
		load_file = string(val);
		port = get_string_async("Which port to host on?", "33669");
		exit;
	}*/
	
	init_map(Mediums.file, string(val));
	map_loaded = true;
	
	if global.action == "server"
		instance_create_depth(x, y, 0, obj_server)
}

/*else if i_d == port{
	with(){
		port = other.port;
		
		socket = network_create_server(network_socket_tcp, real(val), 1);
		if (socket<0){
			txt = "server creation failed";
			die = true;
		} else {
			txt = "Server created";
			init_map(Mediums.file, other.load_file);
			other.map_loaded = true;
		}
			
	}
	

}
*/
