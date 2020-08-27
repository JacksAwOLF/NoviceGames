/// @description Insert description here
// You can write your code in this editor



var i_d = ds_map_find_value(async_load, "id");
var t = ds_map_find_value(async_load, "type");

//debug("for", global.action, "id:", i_d, "socket", socket, "t", t);

switch(t) {

	case network_type_connect:
		osocket = ds_map_find_value(async_load, "socket");
		oip = ds_map_find_value(async_load, "ip");
		
		if (global.action == "playw") txt = "Client Connected "+string(oip);
		else txt = "Connected to Server "+string(oip)
		break;
		
	case network_type_disconnect:
		osocket = -1;
		oip = -1;
		
		if (global.action == "playw") txt = "Client Disconnected";
		else txt = "Lost Connection to Server";
		break;
		
	case network_type_data:
		var buff = ds_map_find_value(async_load, "buffer");
		read_buffer(buff);
		break;
}
