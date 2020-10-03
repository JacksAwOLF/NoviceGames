
/// @description Updates the prospective path for the selected soldier
/// @param shouldClearPath Boolean whether to clear the paths
function soldier_update_path(shouldClearPath) {

	if (global.selectedSoldier) {
		// reset poss_paths if exists
		if (global.poss_paths != -1) {
			for (var i = 0; i < array_length(global.poss_paths); i++)
				global.poss_paths[i].possible_path = max(0, global.poss_paths[i].possible_path-1);
			global.poss_paths = -1;
		}
		
		if (!shouldClearPath && global.prevHoveredTile.possible_move) {
			var mobility = global.movement[get_soldier_type(global.selectedSoldier.soldier)] - global.pathCost;
			global.poss_paths = get_path_to(global.prevHoveredTile.pos,mobility);
				
			for (var i = 0; i < array_length(global.poss_paths); i++)
				global.poss_paths[i].possible_path += 1;
		}
		
	}
}
