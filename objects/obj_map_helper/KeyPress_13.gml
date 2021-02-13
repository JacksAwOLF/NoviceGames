/// @description Next Move

if (global.edit || network_my_turn()){
	
	if (client_connected(true, false) == 0) exit;
	
	//send_buffer(BufferType.yourMove, []);
	
	
	advance_planes();
	
	
	next_move();// update won is in here
}
