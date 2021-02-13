// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

enum BufferType{
	yourMove, mapData,
	soldierMoved,  soldierAttacked,  soldierCreated,  soldierDestroyed,
	changeHutPosition,
	formationCombine, formationRemoveTile, formationAddTile, formationDelete,
	finallyDeployPlane, planeMoved,
	beaconCreate, beaconDestroy,
};

// number of buffer_u16 (2 bytes) that the buffer will conttain
// if the buffer is not all buffer_u16 data, then it can be an array (HAVENT IMPLEMENTED YET)
// note: real buffer size actually +1 bc first byte indicates which BufferType

function create_network_event(tp, sz, rec_f){
	global.network[tp] = {
		type: tp,
		size: sz,
		rec: rec_f,
	}
}



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
	var event = global.network[buffer_read(buff, buffer_u8)];
	var data = [];
	
	if (event.type != BufferType.yourMove && event.type != BufferType.mapData){
		for (var i=0; i<event.size; i++){
			data[i] = buffer_read(buff, buffer_u16);
			if (data[i] == 65535) data[i] = -1; // _u16 sends -1  as 65535
		}
	}
	
	if  (event.type == BufferType.mapData){
		init_map(Mediums.buffer, buff);
		start_sound("connected", 0, false);
	}
	else event.rec(data);
	
	buffer_delete(buff);
}


function network_my_turn(){
	return global.playas == global.turn%2;
}


/// @function sends a buffer of type, look  in network script
function send_buffer(type, data, forceSend){
	
	if  (forceSend == undefined) forceSend = false;
	
	// only send a buffer if it is my turn...
	// if it isn't, that means this function is called while executing
	// the recieved  buffers
	if ((!global.edit && network_my_turn() && instance_number(obj_server) >= 1) || forceSend){
		
		var t = instance_find(obj_server, 0);
		var n = global.network[type].size;
		var buff = buffer_create(2*n+1, buffer_fixed, 1);
		
		buffer_seek(buff, buffer_seek_start, 0);
		buffer_write(buff, buffer_u8, type);
		
		if (type != BufferType.yourMove)
			for (var i=0; i<n; i++)
				buffer_write(buff, buffer_u16, real(data[i]));
		
		
		var s = (global.action == "client" ? t.socket : t.osocket);
		
		network_send_packet(s, buff, buffer_get_size(buff));
		
		buffer_delete(buff);
	}
	
}






// network events


create_network_event(
	BufferType.yourMove, 0,
	function(data){
		next_move();
		var t = instance_find(obj_server, 0);
		t.txt = "Your move!!!";
		start_sound("turn", 0, false);
});


create_network_event(
	BufferType.mapData, 0,
function(){});



// soldier

create_network_event(
	BufferType.soldierMoved, 3,
	function(data){
		soldier_execute_move(global.grid[data[0]], data[1], data[2]);
});

create_network_event(
	BufferType.soldierAttacked, 5,
	function(data){
		var attacker =  decode_possible_attack_objects(data[0], data[2]),
			attacked = decode_possible_attack_objects(data[1], data[3]);
			
		soldier_execute_attack(attacker, attacked, data[4]); 
});

create_network_event(
	BufferType.soldierCreated, 6,
	function(data){
		create_soldier(
			data[0], data[1], data[2],  
			decode_possible_creation_objects(data[3], data[4]), 
			false, true, data[5]
		); 
});

create_network_event(
	BufferType.soldierDestroyed, 2,
	function(data){
		destroy_soldier(decode_possible_attack_objects(data[0], data[1]), true);
});





// huts

create_network_event(
	BufferType.changeHutPosition, 2,
	function(data){
		exchange_hut_spawn_position(data[0], data[1]);
});






// planes

create_network_event(
	BufferType.finallyDeployPlane, 3,
	function(data){
		var planeUnitId = data[0];
		var who = global.grid[data[1]].soldier;
		update_stored_plane(planeUnitId, who);
		who.storedPlaneInst.bindedCarrier = who;
		finalize_deployment(who.storedPlaneInst, data[2]);
		who.bindedPlane.bindedCarrier = who.storedPlaneInst.bindedCarrier;
});

create_network_event(
	BufferType.planeMoved, 3,
	function(data){
		var fromTilePos = data[0];
		var planeArrInd = data[1];
		var toTilePos = data[2];
		plane_execute_move(global.grid[fromTilePos].planeArr[planeArrInd], toTilePos);
});





// formation
create_network_event(
	BufferType.formationAddTile, 2,
	function(data){
		addIntoFormationId(global.grid[data[0]], data[1])
});

create_network_event(
	BufferType.formationCombine, 2,
	function(data){
		addIntoFormationSoldier(global.grid[data[0]], global.grid[data[1]]);
});

create_network_event(
	BufferType.formationRemoveTile, 2,
	function(data){
		removeFromFormation(data[0], global.grid[data[1]]);
});

create_network_event(
	BufferType.formationDelete, 1,
	function(data){
		disbandEntireFormation(data[0]);
});





