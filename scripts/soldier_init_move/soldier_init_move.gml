

// return if tileId is a possible move for selected soldier or not
// can't see through fog
function possible_move_tiles(tileId) {
	var s = global.grid[tileId];
	
	// cant go here if there is a visible soldier blocking path
	if (s.soldier != -1 && !s.hide_soldier) return false;
	
	// cant go if enemy tower is here
	var t = global.selectedSoldier.soldier.team;
	if (s.tower != -1 && s.tower.team != t) return false;
	
	// cant go if enemy hut is here (or nuetral one)
	if (s.hut != -1 && s.hut.team != -1 && s.hut.team != t) return false;
	
	return true;
}


function soldier_init_move() {
	if (global.selectedSoldier != -1){

		// default energy values in global.energy[soldier.type]
		// default move range is in global.movement[solder.type]

		var type = get_soldier_type(global.selectedSoldier.soldier);
		var source = (argument_count > 0 ? argument[0] : global.selectedSoldier);
		
		init_dijkstra(source.pos, 0, global.movement[type]-global.pathCost, -1, 0, 0);
		
		with(global.selectedSoldier.soldier){
	
			if (can-moveCost>=0){
				poss_moves = get_tiles_from(source.pos, move_range - global.pathCost, global.energy[type]);
				if (source != global.selectedSoldier && global.dist[global.selectedSoldier.pos] != -1) 
					poss_moves[array_length(poss_moves)] = global.selectedSoldier;
					
				for (var i=0; i<array_length(poss_moves); i++)
					poss_moves[i].possible_move = true;
				
				// add conquered towers
				if (just_from_hut) {
					debug(team, global.conqueredTowers);
					for (var i=0; i<array_length(global.conqueredTowers[team]); i++){
						with(global.conqueredTowers[team][i])
							if (soldier == -1)
								possible_teleport = true;
					}
					// only teleport once
					just_from_hut = false;
				}
				
			}
			
		}

		
	}
}
