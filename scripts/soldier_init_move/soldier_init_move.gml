

// return if tileId is a possible move for selected soldier or not
// can't see through fog
function possible_move_tiles(tileId) {
	var s = global.grid[tileId];

	// cant go here if there is a visible soldier blocking path
	if (s.soldier != -1 && !s.hide_soldier) return false;

	// cant go if enemy tower is here
	if (s.tower != -1 && !is_my_team(s.tower)) return false;

	// cant go if enemy hut is here (or nuetral one)
	if (s.hut != -1 && (s.hut.team == -1 || !is_my_team(s.hut))) return false;

	return true;
}

function possible_move_tiles_including_selected(tilePos, fromTilePos) {
	var s = global.grid[tilePos], ss = s.soldier, gss = global.selectedSoldier

	// cant go here if there is a visible soldier that is not myself on this tile
		// exception1: the soldier is someone from your formation
		// exception2: the soldier is enemy soldier blocking special tank melee path with an empty space behind
	var specialTank = (gss.special == 1 && gss.unit_id = Units.TANK_M);
	var nextTilePos = next_tile_in_dir(tilePos, get_dir_from_travel(fromTilePos, tilePos))
	if (ss != -1 && s != gss.tileInst && !s.hide_soldier){
		var someoneInMyFormation = (ss.formation != -1 && ss.formation == gss.formation);
		var tankMSpecial = false;
		if (fromTilePos != undefined && specialTank && gss.team != ss.team)
			if (nextTilePos != -1 && global.grid[nextTilePos].soldier == -1)
				tankMSpecial = true;
		
		if (!someoneInMyFormation && !tankMSpecial) return false;
	}

	// cant go if enemy tower is here
	if (s.tower != -1 && !is_my_team(s.tower)) return false;

	// cant go if enemy hut is here (or nuetral one)
	if (s.hut != -1 && (s.hut.team == -1 || !is_my_team(s.hut) ) ) return false;
	
	// oh right you also cant go here if you are special, 
	// the next tile is off the grid,
	// and the previous tile was an enemy soldier.
	// if you could, you would push the enemy soldier off the gri
	if (specialTank && nextTilePos == -1 && global.grid[fromTilePos].soldier != -1 && fromTilePos != gss.tileInst.pos)
		return false;

	return true;
}




// assuming that global.selectedSoldier is soldier to move and that
// this function is being used to calculate possible moves for selectedSoldier
function possible_move_considering_weather(tilePos, energyTo, leftoverDistance, fromTilePos) {
	if (!possible_move_tiles_including_selected(tilePos, fromTilePos))
		return false;
		
	switch (global.weather) {
		case Weather.RAINY:
			var rowDiff = getRowDiff(tilePos, global.rain_center_pos);
			var colDiff = getColDiff(tilePos, global.rain_center_pos);
			
			// if outside rain, resume normal operation
			if (rowDiff*rowDiff + colDiff*colDiff > global.rain_radius_squared)
				break;
				
		case Weather.SNOWY:
			// allow if adjacent to selectedSoldier or snowy and there's a road
			if (abs(getRowDiff(tilePos, global.selectedSoldier.tileInst.pos)) + abs(getColDiff(tilePos, global.selectedSoldier.tileInst.pos)) == 1)
				return true;
			else if (global.grid[tilePos].road && global.weather == Weather.SNOWY)
				return true;
			
			// if you can move to another tile, this tile is reachable
			var dir = [global.mapWidth, -global.mapWidth, 1, -1];
			for (var i = 0; i < 4; i++) {
				var nxtTilePos = tilePos + dir[i];
				
				if (nxtTilePos < 0 || nxtTilePos >= global.mapWidth * global.mapHeight)
					continue;
				else if (energyTo[get_tile_type(global.grid[nxtTilePos], true)] <= leftoverDistance)
					return true;
			}
			
			
			return false;
	}
	
	return true;
}


function soldier_init_move() {
	if (global.selectedSoldier == -1)
		return;


	// default energy values in global.energy[soldier.unit_id]
	// default move range is in global.movement[solder.unit_id]

	var source = (argument_count > 0 ? argument[0] : global.selectedSoldier.tileInst);

	with(global.selectedSoldier){
		if (can-moveCost>=0){
			
			global.poss_moves = get_tiles_from(
				source.pos, move_range-global.pathCost, global.energy[unit_id], true,
				(is_plane(id) ? return_true : possible_move_considering_weather)
			);

			if (source != tileInst && global.dist[tileInst.pos] != -1)
				global.poss_moves[array_length(global.poss_moves)] = tileInst;

			for (var i=0; i<array_length(global.poss_moves); i++)
				global.poss_moves[i].possible_move = true;
		}

		else global.poss_moves = []
		
		global.unitOptionsBar.unit_options = global.unitOptions[unit_id][special];
	}

}


function soldier_init_move_formation(pos){
	
	var arr = global.formation[soldier.formation].tiles,
		mapSize = global.mapWidth * global.mapHeight,
		delta = array_create(mapSize, 0);
	var n = array_length(arr);

	// find the delta's
	for (var i=0; i<n; i++){ 
		if (arr[i] == -1)
			continue;

		global.selectedSoldier = arr[i].soldier;
		if (arr[i] == -1) continue;
		soldier_init_move();

		var pmove = global.poss_moves;   
		
		
		for (var j=0; j<array_length(pmove); j++){
			 delta[getPos(
				(getRowDiff(arr[i].pos, pmove[j].pos) + global.mapHeight) % global.mapHeight,
				(getColDiff(arr[i].pos, pmove[j].pos) + global.mapWidth) % global.mapWidth
			)] += 1;
			
			
		}

		erase_blocks(true);
	}

	// light up the tiles that are possible moves
	for (var i=0; i<mapSize; i++)
		if (delta[i] == n)
			global.grid[ updatePos(pos, getRow(i), getCol(i)) ].possible_move = true;

	global.selectedSoldier = global.grid[pos].soldier;
}
