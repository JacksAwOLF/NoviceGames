/// @description Insert description here
// You can write your code in this editor

if (global.edit || network_my_turn()){
	if (network_my_turn()){
		debug("sending that next move buffer");
		send_buffer(BufferDataType.yourMove, []);
	}
	next_move();
}
