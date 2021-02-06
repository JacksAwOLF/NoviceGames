/// all the code relating to beacons






// called in load_tiles after all the variables are loaded
// creates the global variables to keep track of beacons on each side
function beacon_contruct_global(){
	global.beacons = [[],[]];
	with(obj_tile) if (beacon != -1)
		beacon.linkedSoldier.beaconIndex = add_into_array(global.beacons[beacon.linkedSoldier.team], pos);
		
}

// called in obj_tile draw event
function beacon_draw(scale_factor){
	if (beacon != -1 && (beacon.linkedSoldier.team == global.turn%2 || !hide_soldier) ){
		draw_sprite_ext(spr_bacon, 0, x, y, scale_factor, scale_factor, 0, c_white, 1);	
		if (beacon.num != -1) draw_text(x, y, beacon.num);
	}
}

// called in obj_tile create event
function beacon_tile_init(){
	beacon = -1;
}

// called in obj_solddieer create event
function beacon_soldier_init(){
	beaconIndex = -1;
}




// called if the user clicks the button
// construct beacon that counts enemy units
	// the soldier creates the beacon at pos
global.buffer_sizes[BufferDataType.beaconCreate] = 2;
function beacon_create(soldier, pos){
	
	if (soldier == undefined) soldier = global.selectedSoldier;
	if (pos == undefined) pos = soldier.tilePos.pos;
	var maxSize = 1, team = soldier.team;
	
	if (get_size_array(global.beacons[team]) >= maxSize
		|| soldier.can != soldier.defaultCan) return;
	
	soldier.can = 0;
	event_perform_object(obj_map_helper, ev_keypress, vk_space);
	soldier.beaconIndex = add_into_array(global.beacons[team], pos);
	
	with(global.grid[pos]){
		beacon = instance_create_depth(x, y, 0, obj_attackable);
		with(beacon){
			num = -1;
			linkedSoldier = soldier;
			tilePos = global.grid[pos];
		}
		beacon.team = soldier.team;
	}
	
	send_buffer(BufferDataType.beaconCreate, [team, pos]);
}

// called in soldiere_destroy before the inst is destroyed
// destroy that beacon
global.buffer_sizes[BufferDataType.beaconDestroy] = 1;
function beacon_destroy(tilePos, sendBuffer){ debug("destroy this beacon");
	with(global.grid[tilePos]){
		if (beacon == -1) return;
	
		if (sendBuffer) 
			send_buffer(BufferDataType.beaconDestroy, [ tilePos ]);
	
		with(beacon){
			num = -1;
			with(linkedSoldier){
				global.beacons[team][beaconIndex] = -1;
				beaconIndex = -1;
			}	
			linkedSoldier = -1;
			instance_destroy();
		}
		beacon = -1;
		
		
	}
	debug("beacon destroyed yea?", global.grid[tilePos].beacon);
}

// called in next_move aftere the turn is incremented
// count num vars for a beacon
function beacon_count(){
	var maxDist = 10;
	var arr = global.beacons[global.turn%2];
	for (var i=0; i<array_length(arr); i++)
		if (arr[i] != -1){
			var tiles = get_tiles_from_euclidean(arr[i], maxDist, return_true);
			var beaconTile = global.grid[arr[i]];
			var num = 0;
			for (var j=0; j<array_length(tiles); j++){
				var s = tiles[j].soldier
				if (s != -1 && s.team != beaconTile.beacon.linkedSoldier.team)
					num += 1;
			}
			
			global.grid[arr[i]].beacon.num = num;
		}
}

