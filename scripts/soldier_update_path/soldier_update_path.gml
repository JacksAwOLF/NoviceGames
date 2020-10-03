
/// @description Updates the prospective path for the selected soldier
/// @param clear_path Boolean whether to clear the paths
function soldier_update_path(shouldClearPath) {

	if (global.selectedSoldier) {
		with(global.selectedSoldier.soldier) {
		
			// reset poss_paths if exists
			if (poss_paths != -1) {
				for (var i = 0; i < array_length(poss_paths); i++)
					poss_paths[i].possible_path = max(0, poss_paths[i].possible_path-1);
				poss_paths = -1;
			}

		
			if (!shouldClearPath && global.prevHoveredTiles[0].possible_move) {
				var mobility = global.movement[get_soldier_type(id)] - global.pathCost;
				poss_paths = get_path_to(global.prevHoveredTiles[0].pos,mobility);
				
				for (var i = 0; i < array_length(poss_paths); i++)
					poss_paths[i].possible_path += 1;
			}
		}
	}


}
