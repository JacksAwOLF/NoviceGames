/// @description Insert description here
// You can write your code in this editor

//var i_d = ds_map_find_value(async_load, "id");
var t = ds_map_find_value(async_load, "type");

//debug("for", global.action, "id:", i_d, "socket", socket, "t", t);

switch(t) {

	case network_type_data:
		var buff = ds_map_find_value(async_load, "buffer");
		read_buffer(buff);
		break;



	// these next two events are for server only
	case network_type_connect:
		osocket = ds_map_find_value(async_load, "socket");
		oip = ds_map_find_value(async_load, "ip");
		txt = "Client "+string(oip)+" Connected";
		
		// send over the map and playAs data
		save_map(Mediums.buffer, osocket); // osocket is actually the one that is the client
		
		break;
		
	case network_type_disconnect:
		osocket = -1;
		txt = "Client "+string(oip)+" Disconnected";
		break;
}
