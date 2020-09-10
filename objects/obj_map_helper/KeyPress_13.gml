/// @description Next Move

if (global.edit || network_my_turn()){
	
	if (client_connected(true, false) == 0) exit;
	
	//send_buffer(BufferDataType.yourMove, []);
	
	
	next_move();// update won is in here
}
