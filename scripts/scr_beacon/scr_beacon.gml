/// all the code relating to beacons


// called in load_tiles after all the variables are loaded
// creates the global variables to keep track of beacons on each side
function beacon_contruct_global(){
	
	global.beacons = [[],[]];
	with(obj_tile) if (beaconSoldier != -1)
		beaconSoldier.beaconIndex = add_into_array(global.beacons[beaconSoldier.team], pos);
		
}

// called if the user clicks the button
// construct beacon that counts enemy units
	// the soldier creates the beacon at pos
function beacon_create(soldier, pos){
	
	if (soldier == undefined) soldier = global.selectedSoldier;
	if (pos == undefined) pos = soldier.tilePos.pos;
	var maxSize = 1, team = soldier.team;
	
	if (get_size_array(global.beacons[team]) >= maxSize
		|| soldier.can != soldier.defaultCan) return;
	
	soldier.can = 0;
	soldier.beaconIndex = add_into_array(global.beacons[team], pos);
	
	with(global.grid[pos]){
		beaconNum = -1;
		beaconSoldier = soldier;
	}
	
	send_buffer(BufferDataType.beaconCreate, [team, pos]);
}	

// called in soldiere_destroy before the inst is destroyed
// destroy that beacon
function beacon_destroy(soldierInst){
	with (soldierInst) { 
		if (unit_id == Units.IFV_S && special == 1 && beaconIndex != -1){ 
			var pos = global.beacons[team][beaconIndex];
			with(global.grid[pos]){
				beaconNum = -1;
				beaconSoldier = -1;
			}
			global.beacons[team][beaconIndex] = -1;
			beaconIndex = -1;
		}
	}
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
				if (s != -1 && s.team != beaconTile.beaconSoldier.team)
					num += 1;
			}
			
			global.grid[arr[i]].beaconNum = num;
		}
}

// called in obj_tile draw event
function beacon_draw(scale_factor){
	if (beaconSoldier != -1 && (beaconSoldier.team == global.turn%2 || !hide_soldier) ){
		draw_sprite_ext(spr_bacon, 0, x, y, scale_factor, scale_factor, 0, c_white, 1);	
		if (beaconNum != -1) draw_text(x, y, beaconNum);
	}
}

// called in obj_tile create event
function beacon_tile_init(){
	beaconSoldier = -1;
	beaconNum = -1;
}

// called in obj_solddieer create event
function beacon_soldier_init(){
	beaconIndex = -1;
}