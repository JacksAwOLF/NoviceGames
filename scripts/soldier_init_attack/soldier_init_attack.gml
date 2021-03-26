// finished updating global selected soldier

function get_attack_target(attackingSoldierInst, targetTileInst){ //debug("checking tile", targetTileInst.pos);
	// in the order that you will attack them
	var targets = array("soldier", "tower", "hut", "beacon")
	for (var i=0; i<array_length(targets); i++){
		var oth = variable_instance_get(targetTileInst, targets[i]);	
		
	//	if (targets[i] == "beacon")
			//debug("chekcing", targetTileInst.pos, oth, oth.team, attackingSoldierInst.team);
			
		if (oth != -1 && oth.team != attackingSoldierInst.team){
			//debug("got it");
			return oth;
		}
			
		
	}
	return -1;
}

// return if tileId is a possible attack for selected soldier or not
// can't see through fog
function possible_attack_tiles(tilePos) { 
	var tile = global.grid[tilePos];
	if (tile.hide_soldier) return false;
	return get_attack_target(global.selectedSoldier, tile) != -1;
}

function return_true(tileId){
	return true;
}



// returns if an attack is found or not
function soldier_init_attack(attack_cond) {
	var found = false;

	if (attack_cond == undefined)
		attack_cond = possible_attack_tiles;
		
	if (global.selectedSoldier != -1){

		var p = global.selectedSoldier.tileInst.pos;
	

		with (global.selectedSoldier) { 
			if (can-attackCost>=0) {
				
				// find possible attack tiles
				var num_soldiers = instance_number(obj_attackable);
				if (attack_range*attack_range*4 < num_soldiers)
					global.poss_attacks = get_tiles_from_euclidean(p, attack_range, attack_cond);
				else {
					
					global.poss_attacks = [];
					var cur_x = tileInst.pos % global.mapWidth;
					var cur_y = floor(tileInst.pos / global.mapWidth);
					
					with (obj_attackable) {
						
						if (isActive) {
							
							var test_x = tileInst.pos % global.mapWidth;
							var test_y = floor(tileInst.pos / global.mapWidth);
							
							if (attack_cond(tileInst.pos) &&
								(cur_x-test_x)*(cur_x-test_x) + (cur_y-test_y)*(cur_y-test_y) <= other.attack_range*other.attack_range) {
								
								global.poss_attacks[array_length(global.poss_attacks)] = tileInst;
							}
						}
					}
				}
				
				for (var i=0; i<array_length(global.poss_attacks); i++){
					global.poss_attacks[i].possible_attack = true;
					global.poss_attacks[i].possible_move = false;
					found  = true;
				}
				
			}
		}



	}

	return found;
}
