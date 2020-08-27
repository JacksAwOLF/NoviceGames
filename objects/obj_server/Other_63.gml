/// @description Insert description here
// You can write your code in this editor




var i_d = ds_map_find_value(async_load, "id");
var val = ds_map_find_value(async_load, "result");


if (ds_map_find_value(async_load, "status") <= 0)
	room_goto(rm_start_screen);	
	
else if i_d == serverurl {
	var res = network_connect(socket, val , global.port);
	if (res < 0) txt = "failed to connect to "+string(val);
	else txt = "client created"
}