// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function endingGame(){
	with (obj_server){
		if (socket != -1) network_destroy(socket);
		if (osocket != -1) network_destroy(osocket);


		debug("socket destroyed?");
		debug(socket);
		debug(osocket);
	}
	
	
	ds_list_destroy(global.formation)
}
