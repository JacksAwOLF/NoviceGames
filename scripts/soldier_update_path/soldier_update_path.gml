// argument0: 0 if update based on hovered tile, 1 if erase
if (global.selectedSoldier) {

	with(global.selectedSoldier.soldier) {
		
		// if the variable that stores paths exists, reset it
		if (variable_instance_exists(id, "poss_paths") && poss_paths != -1) 
			for (var i = 0; i < array_length_1d(poss_paths); i++) 
				poss_paths[i].possible_path = false;
	
		//debug(variable_instance_exists(id, "poss_path"));
		//debug("prev hovered", global.prevHoveredTiles);
	
		poss_paths = -1;
	
		
		if (argument[0] == 0 && global.prevHoveredTiles[0].possible_move) {
			var throughPrev = [];
			var mobility = get_mobility_for(sprite_index);
			mobility[4] = 99;
			
			if (global.prevHoveredTiles[1] != -1) {
				with(global.prevHoveredTiles[1]) {
					
					// we check whether we can draw a path that
					// goes through the previously hovered tils
					if(possible_move) {
						
						var tt = sprite_index;
						if (road) tt = spr_tile_road;
						
						var possible_terrain = array(spr_tile_road, spr_tile_flat, spr_tile_ocean, spr_tile_mountain, spr_tile_border);
						var cost = mobility[1];
						
						cost = cost[posInArray(possible_terrain, tt)];
						throughPrev = get_path_to(global.selectedSoldier.pos,global.prevHoveredTiles[1].pos,
													mobility[0]-cost,-1,true,mobility[1]);
													
						throughPrev[array_length_1d(throughPrev)] = global.prevHoveredTiles[0];
						debug("through: ", throughPrev);
					}
				}
			}
			
			if (array_length_1d(throughPrev) > 1)
				poss_paths = throughPrev;
			else {
				poss_paths = get_path_to(global.selectedSoldier.pos,global.prevHoveredTiles[0].pos,mobility[0],-1,true,mobility[1]);
				debug("used current");
			}
				
			for (var i = 0; i < array_length_1d(poss_paths); i++)
				poss_paths[i].possible_path = true;
			debug(poss_paths);
		}
	}
}