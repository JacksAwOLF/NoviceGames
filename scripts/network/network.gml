// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

enum BufferDataType{
	soldierMoved, 
	soldierAttacked, 
	soldierCreated,  
	changeHutPosition, 
	formationCombine,
	formationRemoveTile,
	yourMove, mapData
};

// number of buffer_u16 (2 bytes) that the buffer will conttain
// if the buffer is not all buffer_u16 data, then it can be an array (HAVENT IMPLEMENTED YET)
// note: real buffer size actually +1 bc first byte indicates which BufferDDataType
global.buffer_sizes[BufferDataType.soldierMoved] = 3;
global.buffer_sizes[BufferDataType.soldierAttacked] = 3;
global.buffer_sizes[BufferDataType.soldierCreated] = 4;
global.buffer_sizes[BufferDataType.changeHutPosition] = 2;
global.buffer_sizes[BufferDataType.formationCombine] = 2;
global.buffer_sizes[BufferDataType.formationRemoveTile] = 2;
global.buffer_sizes[BufferDataType.yourMove] = 0;

/* for naval we  need to encode the attacker
function encode_attacker(tilePos, inst){	
	
}

function decode_attacker(tilePos, num){
	
}
*/

// stupid function
function client_connected(outfalse, outtrue){
	if outfalse == undefined outfalse = true;
	if outtrue == undefined outtrue = true;

	if (global.action == "server"){
		var t = instance_find(obj_server, 0);
		var res = t.osocket != -1;
		if (res && outtrue) t.txt = "Can't quit/save while client still connected";
		else if (!res && outfalse) {
			t.txt = "Waiting for client connection...";
			start_sound("error", 0, false);
		}
		return real(res);
	}
	return -1;
}



/// @function read and execute moves for a buffer (turn must be incremented first)
function read_buffer(buff){
	
	buffer_seek(buff, buffer_seek_start, 0);
	var type  = buffer_read(buff, buffer_u8);
	var data = [];
	
	if (type != BufferDataType.yourMove && type != BufferDataType.mapData)
		for (var i=0; i<global.buffer_sizes[type]; i++)
			data[i] = buffer_read(buff, buffer_u16);
	
	
	switch(type){
		case BufferDataType.soldierMoved:
			soldier_execute_move(global.grid[data[0]], data[1], data[2]);
			break;
			
		case BufferDataType.soldierAttacked:
			soldier_execute_attack(
				global.grid[data[0]].soldier, // assuming only soldiers can make attacks
				decode_possible_attacked_objects(data[1], data[2])
			); 
			break;
			
		case BufferDataType.soldierCreated:
			debug("received", data);
			debug(decode_possible_creation_objects(data[2], data[3]))
			create_soldier(
				data[0], data[1], 
				decode_possible_creation_objects(data[2], data[3]), 
				false
			); 
			break;
		
		case BufferDataType.yourMove:
			next_move();
			var t = instance_find(obj_server, 0);
			t.txt = "Your move!!!";
			start_sound("turn", 0, false);
			break;

		case BufferDataType.mapData:
			init_map(Mediums.buffer, buff);
			start_sound("connected", 0, false);
			break;
			
		case BufferDataType.changeHutPosition:
			exchange_hut_spawn_position(data[0], data[1]);
			break;
		
		case BufferDataType.formationCombine:
			addIntoFormationSoldier(global.grid[data[0]], global.grid[data[1]]);
			break;
			
		case BufferDataType.formationRemoveTile:
			removeFromFormation(data[0], global.grid[data[1]]);
			break;
	}
	
	buffer_delete(buff);
}



function network_my_turn(){
	return global.playas == global.turn%2;
}


/// @function sends a buffer of type, look  in network script
function send_buffer(type, data){
	
	// only send a buffer if it is my turn...
	// if it isn't, that means this function is called while executing
	// the recieved  buffers
	if (!global.edit && network_my_turn() && instance_number(obj_server) >= 1){
		
		var t = instance_find(obj_server, 0);
		var n = global.buffer_sizes[type];
		var buff = buffer_create(2*n+1, buffer_fixed, 1);
		
		buffer_seek(buff, buffer_seek_start, 0);
		buffer_write(buff, buffer_u8, type);
		
		//debug(data, n);
		
		if (type != BufferDataType.yourMove)
			for (var i=0; i<n; i++)
				buffer_write(buff, buffer_u16, real(data[i]));
		
		
		var s = (global.action == "client" ? t.socket : t.osocket);
		network_send_packet(s, buff, buffer_get_size(buff));
		debug("sent", data);
		buffer_delete(buff);
	}
	
}


