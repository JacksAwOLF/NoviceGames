function update_fog() {
	// script just updates the fog based on the current turn and troop positions


	for (var i=0; i<global.mapWidth * global.mapHeight; i++)
		with(global.grid[i])
			hide_soldier = true;
		

	for (var i=0; i<global.mapWidth * global.mapHeight; i++)
		with(global.grid[i])
			if (soldier != -1 && soldier.team == global.turn%2){
				seen = get_vision_tiles_2(global.grid[i]);//get_tiles_from(pos, soldier.vision, 0, false);	
				for (var j=0; j<array_length_1d(seen); j++)
					seen[j].hide_soldier = false;
			}

}
