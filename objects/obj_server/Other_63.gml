/// @description Insert description here
// You can write your code in this editor


var i_d = ds_map_find_value(async_load, "id");
var val = ds_map_find_value(async_load, "result");


if (ds_map_find_value(async_load, "status") <= 0)
	room_goto(rm_start_screen);	
	
else if i_d == serverurl {
	
	var pos = string_pos(":", val);
	if (pos == 0){
		txt = "Add the port after the colon";
		start_sound("error", 0, false);
		die = true;
	}
	
	var url = string_copy(val, 1, pos-1);
	port = string_copy(val, pos+1, string_length(val)-string_length(url)-1);
	port = real(string_digits(port));
	
	socket = network_create_socket(network_socket_tcp);
	var res = network_connect(socket, url , port);
	if (res < 0 || res == 8){
		txt = "failed to connect to "+string(val);
		start_sound("error", 0, false);
		die = true;
	} else txt = "client created";
	
}


else if i_d == port{
	socket = network_create_server(network_socket_tcp, real(val), 1);
	if (socket<0){
		txt = "server creation failed";
		start_sound("error", 0, false);
		die = true;
	} else {
		txt = "Server created";
		
		//with(MH){
		//	init_map(Mediums.file, string(val));
		//	map_loaded = true;
		//}
	}
}

