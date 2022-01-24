/// @function		get_visible_tiles_team()
/// @description	Return an array of tileInstances that can be seen by the current team
function get_visible_tiles_team(){
	var tiles = [], sze = 0;
	
	for (var i = 0; i < ds_list_size(global.allSoldiers[global.turn % 2]); i++) {
		with (global.allSoldiers[global.turn % 2][i]) {
			if (isActive) {
				var seen = get_vision_tiles(id);
				for (var j = 0; j < array_length(seen); j++) {
					var isContained = false;
					for (var k = 0; k < sze; k++) {
						if (tiles[k] == seen[j]) {
							isContained = true;
							break;
						}
					}
					
					if (!isContained)
						tiles[sze++] = seen[j];
				}
			}
		}
	}
	
	return tiles;
}


function get_visible_enemy_soldiers() {
	var soldiers = [], sze = 0;
	for (var i = 0; i < global.mapHeight; i++) {
		for (var j = 0; j < global.mapWidth; j++) {
			with (global.grid[getPos(i, j)]) {
				if (!hide_soldier && soldier != -1 && !is_my_team(soldier))
					soldiers[sze++] = soldier;
			}
		}
	}
	
	return soldiers;
}

function get_soldiers_from_team(team_id) {
	var soldiers = [], sze = 0;
	with (obj_infantry) {
		if (isActive && team == team_id)
			soldiers[sze++] = id;
	}
	
	return soldiers;
}

