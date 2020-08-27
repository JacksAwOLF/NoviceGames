// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


// data to send should just be moving data and attack data
// and soldier create data or destroy data
		

enum BufferDataType{
	soldierMoved, soldierAttacked, soldierCreated,  yourMove
};

global.buffer_sizes = array(7, 5, 5, 1);     //  number of bytes each buffer type has

global.buffer_dataT = array( 
	array(buffer_u16, buffer_u16, buffer_u16),   // moving data: fromTilePos toTilePos soldierDirection
	array(buffer_u16, buffer_u16),                 //  attack data:  fromTilePos  toTilePos
	array(buffer_u16, buffer_u16),           // create data:  spriteIndex     tilePos
	[]
);



/// @function read and execute moves for a buffer (turn must be incremented first)

function read_buffer(buff){
	
	buffer_seek(buff, buffer_seek_start, 0);
	var type  = buffer_read(buff, buffer_u8);
	var data = [];
	if (type != BufferDataType.yourMove)
		for (var i=0; i<array_length(global.buffer_dataT[type]); i++)
			data[i] = buffer_read(buff, global.buffer_dataT[type][i]);
	
	
	switch(type){
		case BufferDataType.soldierMoved:
			soldier_execute_move(data[0], data[1], data[2]);
			break;
			
		case BufferDataType.soldierAttacked:
			soldier_execute_attack(data[0], data[1]);
			break;
			
		case BufferDataType.soldierCreated:
			create_soldier(data[0], data[1], true, false); // create soldier from hut
			break;
		
		case BufferDataType.yourMove:
			next_move();
			var t = instance_find(obj_server, 0);
			t.txt = "Your move!!!";
			break;
	}
	
	buffer_delete(buff);
}



function network_my_turn(){
	return (global.action == "playw" && global.turn%2==0 || 
		global.action == "playb" && global.turn%2==1);
}


/// @function sends a buffer of type, look  in network script
function send_buffer(type, data){
	
	// only send a buffer if it is my turn...
	// if it isn't, that means this function is called while executing
	// the recieved  buffers
	if (network_my_turn() && instance_number(obj_server) >= 1){
		var buff = buffer_create(global.buffer_sizes[type], buffer_fixed, 1);
		
		buffer_seek(buff, buffer_seek_start, 0);
		buffer_write(buff, buffer_u8, type);
		
		if (type != BufferDataType.yourMove)
			for (var i=0; i<array_length(global.buffer_dataT[type]); i++)
				buffer_write(buff, global.buffer_dataT[type][i], data[i]);
		
		var t = instance_find(obj_server, 0);
		var s = (global.action == "playb" ? t.socket : t.osocket);
		network_send_packet(s, buff, buffer_get_size(buff));
		
		buffer_delete(buff);
	}
}


