

// return if tileId is a possible attack for selected soldier or not
// can't see through fog
function possible_attack_tiles(tileId) { 
	
	var s = global.grid[tileId];
	if (s.hide_soldier || s.soldier + s.tower + s.hut == -3) return false;
	
	// in the order that you will attack them
	var targets = array("soldier", "tower", "hut")
	
	for (var i=0; i<array_length(targets); i++){
		var oth = variable_instance_get(s, targets[i]);
		if (oth != -1 && oth.team != global.selectedSoldier.soldier.team)
			return true;
	}

	return false;
}

function return_true(tileId){
	return true;
}



// call this from the tile that you want to initiate attacking from
// returns if an attack is found or not
function soldier_init_attack() {
	var found = false;

	if (global.selectedSoldier != -1){

		var p = pos;
	

		with (global.selectedSoldier.soldier){
			if (can-attackCost>=0){
				
				// soldier_erase_attack();
				global.poss_attacks = get_tiles_from_euclidean(p, attack_range);
				for (var i=0; i<array_length(global.poss_attacks); i++){
					global.poss_attacks[i].possible_attack = true;
					found  = true;
				}
				
			}
		}



	}

	return found;
}
