/// all the code relating to beacons






// called in load_tiles after all the variables are loaded
// creates the global variables to keep track of beacons on each side
function beacon_contruct_global(){
	global.beacons = [0,0];
	with(obj_tile) if (beacon != -1) {
		global.beacons[beacon.team] += 1;
		beacon.linkedSoldier.beaconPos = pos;
	}
}

// called in obj_tile draw event
function beacon_draw(scale_factor){
	if (beacon != -1 && (beacon.team == global.turn%2 || !hide_soldier) ){
		var color = c_white;
		if (beacon.team != global.playas) color = c_red;
		draw_sprite_ext(spr_bacon, 0, x, y, scale_factor, scale_factor, 0, color, 1);	
		if (beacon.num != -1  && beacon.team == global.playas) draw_text(x, y, beacon.num);
	}
}

// called in obj_tile create event
function beacon_tile_init(){
	beacon = -1;
}

// called in obj_solddieer create event
function beacon_soldier_init(){
	beaconPos = -1;
}


// called if the user clicks the button
// construct beacon that counts enemy units
	// the soldier creates the beacon at pos
create_network_event(
	BufferType.beaconCreate, 1,
	function(data){
		with(global.grid[data[0]])
			beacon_create(soldier, pos);
});

function beacon_create(soldier, pos){
	
	var maxSize = 1;
	
	if (soldier == undefined) soldier = global.selectedSoldier;
	if (pos == undefined) pos = soldier.tileInst.pos;
	
	if (global.beacons[soldier.team] >= maxSize
		|| soldier.can != soldier.defaultCan 
		|| global.grid[pos].beacon != -1) return;
	
	
	global.beacons[soldier.team] += 1;
	soldier.can = 0;
	event_perform_object(obj_map_helper, ev_keypress, vk_space);
	soldier.beaconPos = pos;
	
	with(global.grid[pos]){
		beacon = instance_create_depth(x, y, 0, obj_attackable);
		with(beacon){
			num = -1;
			tileInst = global.grid[pos];
			linkedSoldier = soldier;
		}
		beacon.team = soldier.team;
	}
	
	send_buffer(BufferType.beaconCreate, [pos]);
}






// called in soldiere_destroy before the inst is destroyed
// destroy that beacon
create_network_event(
	BufferType.beaconDestroy, 1,
	function(data){
		beacon_destroy(data[0], false);
});
function beacon_destroy(tilePos, sendBuffer){ 
	debug(global.action, "destroying beacon at", tilePos);
	
	with(global.grid[tilePos]){
		if (beacon == -1) return;
	
		if (sendBuffer) 
			send_buffer(BufferType.beaconDestroy, [ tilePos ]);
		
		global.beacons[beacon.team] -= 1;
		instance_destroy(beacon);
		beacon = -1;
	}
}

// only called in the solddier_destroy event
function beacon_soldier_destroy(){	
	if (beaconPos != -1)
		beacon_destroy(beaconPos, false);
}

// called in next_move aftere the turn is incremented
// count num vars for a beacon
function beacon_count(){
	var maxDist = 10;
	
	with(obj_infantry){
		if (beaconPos != -1 && global.turn%2 == team){
						
			var beaconTile = global.grid[beaconPos];
			if (beaconTile.beacon != -1){
				var tiles = get_tiles_from_euclidean(beaconPos, maxDist, return_true);
			
				var num = 0;
				for (var j=0; j<array_length(tiles); j++){
					var s = tiles[j].soldier
					if (s != -1 && s.team != team)
						num += 1;
				}
			
				beaconTile.beacon.num = num;
				
			}  else beaconPos  = -1;
			
		}
	}
	
}

