function soldier_init_move() {
	if (global.selectedSoldier != -1){

		//debug("selected is ", global.selectedSoldier);

		// default energy values in global.energy[soldier.type]
		// default move range is in global.movement[solder.type]
		// change in load_map...

		var type = get_soldier_type(global.selectedSoldier.soldier);
		var source = (argument_count > 0 ? argument[0] : global.selectedSoldier);
		
		init_dijkstra(source.pos, 0, global.movement[type]-global.pathCost, -1, 0, 0);
		
		with(global.selectedSoldier.soldier){
	
			if (can){
				
				poss_moves = get_tiles_from(source.pos, global.movement[type] - global.pathCost, -1, true, global.energy[type]);
				if (source != global.selectedSoldier && global.dist[global.selectedSoldier.pos] != -1) {
					//debug("distance to selected soldier is: ", global.dist[global.selectedSoldier.pos]);
					poss_moves[array_length_1d(poss_moves)] = global.selectedSoldier;
				}
				
				debug("can and poss_moves: ", poss_moves);
				for (var i=0; i<array_length_1d(poss_moves); i++)
					poss_moves[i].possible_move = true;
			}
		}

		

	}
}
