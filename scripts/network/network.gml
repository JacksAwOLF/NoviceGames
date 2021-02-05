// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

enum BufferDataType{
	soldierMoved, 
	soldierAttacked, 
	soldierCreated,  
	changeHutPosition, 
	formationCombine,
	formationRemoveTile,
	formationAddTile,
	formationDelete,
	deployPlane,
	finallyDeployPlane,
	planeMoved,
	yourMove, mapData,
	soldierDestroyed,
	beaconCreate,
};

// number of buffer_u16 (2 bytes) that the buffer will conttain
// if the buffer is not all buffer_u16 data, then it can be an array (HAVENT IMPLEMENTED YET)
// note: real buffer size actually +1 bc first byte indicates which BufferDataType
global.buffer_sizes[BufferDataType.soldierMoved] = 3;
global.buffer_sizes[BufferDataType.soldierAttacked] = 4;
global.buffer_sizes[BufferDataType.soldierCreated] = 6;
global.buffer_sizes[BufferDataType.changeHutPosition] = 2;
global.buffer_sizes[BufferDataType.formationCombine] = 2;
global.buffer_sizes[BufferDataType.formationRemoveTile] = 2;
global.buffer_sizes[BufferDataType.yourMove] = 0;
global.buffer_sizes[BufferDataType.deployPlane] = 2;
global.buffer_sizes[BufferDataType.finallyDeployPlane] = 3;
global.buffer_sizes[BufferDataType.planeMoved] = 3;
global.buffer_sizes[BufferDataType.soldierDestroyed] = 2;
global.buffer_sizes[BufferDataType.formationAddTile] = 2;
global.buffer_sizes[BufferDataType.beaconCreate] = 2;

// if we need to update more global variables in the future, write a more generalized function
global.buffer_sizes[BufferDataType.formationDelete] = 1;		



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
			var attacker =  decode_possible_attack_objects(data[0], data[2]),
				attacked = decode_possible_attack_objects(data[1], data[3]);
			
			soldier_execute_attack(attacker, attacked); 
			break;
			
		case BufferDataType.soldierCreated:
			if (data[3] == 65535) data[3] = -1;
			if (data[4] == 65535) data[4] = -1;
		
			create_soldier(
				data[0], data[1], data[2],  
				decode_possible_creation_objects(data[3], data[4]), 
				false, true, data[5]
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
			
		case BufferDataType.formationAddTile:
			addIntoFormationId(global.grid[data[0]], data[1])
			break;
			
		case BufferDataType.formationDelete:	
			disbandEntireFormation(data[0]);
			break;
	
		case BufferDataType.finallyDeployPlane:
			if (data[2] == 65535) data[2] = -1;
			var planeUnitId = data[0];
			var who = global.grid[data[1]].soldier;
			update_stored_plane(planeUnitId, who);
			who.storedPlaneInst.bindedCarrier = who;
			finalize_deployment(who.storedPlaneInst, data[2]);
			who.bindedPlane.bindedCarrier = who.storedPlaneInst.bindedCarrier;
			break;
			
		case BufferDataType.planeMoved:
			var fromTilePos = data[0];
			var planeArrInd = data[1];
			var toTilePos = data[2];
			plane_execute_move(global.grid[fromTilePos].planeArr[planeArrInd], toTilePos);
			break;
			
		case BufferDataType.soldierDestroyed:
			destroy_soldier(decode_possible_attack_objects(data[0], data[1]), true);
			break;
		
		case BufferDataType.beaconCreate:
			beacon_create(data[0], data[1]);
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
		
		if (type != BufferDataType.yourMove)
			for (var i=0; i<n; i++)
				buffer_write(buff, buffer_u16, real(data[i]));
		
		
		var s = (global.action == "client" ? t.socket : t.osocket);
		network_send_packet(s, buff, buffer_get_size(buff));
		
		buffer_delete(buff);
	}
	
}


