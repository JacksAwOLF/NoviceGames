

// return if tileId is a possible move for selected soldier or not
// can't see through fog
function possible_move_tiles(tileId) {
	var s = global.grid[tileId];
	
	// cant go here if there is a visible soldier blocking path
	if (s.soldier != -1 && !s.hide_soldier) return false;
	
	// cant go if enemy tower is here
	if (s.tower != -1 && !is_my_team(s.tower)) return false;
	
	// cant go if enemy hut is here (or nuetral one)
	if (s.hut != -1 && s.hut.team != -1 && !is_my_team(s.hut)) return false;
	
	return true;
}

function possible_move_tiles_including_selected(tileId) {
	var s = global.grid[tileId];
	
	// cant go here if there is a visible soldier blocking path
	if (s.soldier != -1 && s != global.selectedSoldier && !s.hide_soldier) return false;
	
	// cant go if enemy tower is here
	if (s.tower != -1 && !is_my_team(s.tower)) return false;
	
	// cant go if enemy hut is here (or nuetral one)
	if (s.hut != -1 && s.hut.team != -1 && !is_my_team(s.hut)) return false;
	
	return true;
}

function soldier_init_move() {
	if (global.selectedSoldier != -1){

		// default energy values in global.energy[soldier.type]
		// default move range is in global.movement[solder.type]

		var type = get_soldier_type(global.selectedSoldier.soldier);
		var source = (argument_count > 0 ? argument[0] : global.selectedSoldier);
		
		with(global.selectedSoldier.soldier){
	
			if (can-moveCost>=0){
				global.poss_moves = get_tiles_from(source.pos, move_range-global.pathCost, global.energy[type], true, 
												   possible_move_tiles_including_selected);
												   
				if (source != global.selectedSoldier && global.dist[global.selectedSoldier.pos] != -1) 
					global.poss_moves[array_length(global.poss_moves)] = global.selectedSoldier;
					
				for (var i=0; i<array_length(global.poss_moves); i++)
					global.poss_moves[i].possible_move = true;
			
			
				if (justFromHut != -1){
					for (var i=0; i<array_length(global.conqueredTowers[team]); i++){
						with(global.conqueredTowers[team][i])
							if (soldier == -1 && originHutPos == -1)
								possible_teleport = true;
					}
					
					if (justFromHut != global.selectedSoldier.pos) 
						global.grid[justFromHut].possible_teleport = true;
				}
				
				
			}
			
		}

		
	}
}
