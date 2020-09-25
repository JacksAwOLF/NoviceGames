/// @function script just updates the fog based on the current turn and troop positions
function update_fog() {
	if (global.edit && !global.fogOn) exit;
	
	for (var i=0; i<global.mapWidth * global.mapHeight; i++)
		with(global.grid[i])
			hide_soldier = true;
		

	for (var i=0; i<global.mapWidth * global.mapHeight; i++)
		with(global.grid[i])
			if (soldier != -1 && soldier.team == global.turn%2){
				seen = get_vision_tiles_2(global.grid[i]);
				for (var j=0; j<array_length(seen); j++){
					seen[j].hide_soldier = false;
				}
			}
	
	
	update_enemy_outline();
}


function update_enemy_outline() {
	
	for (var i=0; i<global.mapWidth * global.mapHeight; i++) {
		with(global.grid[i]) {
			enemy_vision = false;
			possible_enemy_move = false;
			possible_enemy_attack = false;
		}
	}
	
	for (var i=0; i<global.mapWidth * global.mapHeight; i++) {
		
		if (global.grid[i].soldier != -1 && !is_my_team(global.grid[i].soldier) &&
			global.grid[i].soldier.display_if_enemy && !global.grid[i].hide_soldier) {
				
			var seen = get_vision_tiles_2(global.grid[i]);
			
			var type = get_soldier_type(global.grid[i].soldier);
			var moves = get_tiles_from(i, global.movement[type], global.energy[type]);
			
			// we could change this to the global variable too?
			var attack = get_tiles_from_euclidean(i, global.grid[i].soldier.attack_range);
	
			for (var j = 0; j < array_length(seen); j++)
				seen[j].enemy_vision = true;
				
			for (var j = 0; j < array_length(moves); j++)
				moves[j].possible_enemy_move = true;
				
			for (var j = 0; j < array_length(attack); j++)
				if (attack[j].soldier == -1 || is_my_team(attack[j].soldier))
					attack[j].possible_enemy_attack = true;
		}
	}
}
