
function plane_execute_move(planeInst, toTilePos) {
	
	var fromTileInst = planeInst.tileInst;
	var fromTilePlaneIndex = posInArray(fromTileInst.planeArr, planeInst);
	remove_from_array(fromTileInst.planeArr, planeInst);
	add_into_array(global.grid[toTilePos].planeArr, planeInst);
	planeInst.tileInst = global.grid[toTilePos];

	//	planeInst.direction = dir; for now, no direction

	if (global.edit || network_my_turn()) update_fog();
	send_buffer(BufferType.planeMoved, array(fromTileInst.pos, fromTilePlaneIndex, toTilePos));
}

// Return [moveHereCost, collisionTileInst or -1 if doesn't exist]
function soldier_attempt_move(frTileInst, path) {
	var soldier = frTileInst.soldier;
	var nPath = array_length(path);
	
	// get the index of the path where there is an enemy soldier
	var collisionInd = nPath-2;
	var moveHereCost = 0;
	
	while (collisionInd >= 0){ 
		var tile = path[collisionInd];
		if (tile.soldier!=-1 && tile != soldier.tileInst) break;	
		moveHereCost += global.energy[soldier.unit_id][get_tile_type(tile)];
		collisionInd--;
	}
	
	var destTileInd = collisionInd + 1;
	if (collisionInd != -1){
					
		if (soldier.special == 1 && soldier.unit_id == Units.TANK_M){
					
			// move the enemy soldier out of the way
			var a = path[collisionInd+1].pos, b = path[collisionInd].pos, 
				c = next_tile_in_dir(b, get_dir_from_travel(a, b));
			if (c != -1) soldier_execute_move(path[collisionInd], c);
						
			// change the final destination tile
			destTileInd = collisionInd;
		} 
	}
				
	var dir = soldier.direction;
	if (destTileInd + 1 < nPath)
		dir = get_dir_from_travel(path[destTileInd+1].pos, path[destTileInd].pos);
	soldier_execute_move(frTileInst, path[destTileInd].pos, dir);
	
	
	return [moveHereCost, (collisionInd == -1 ? -1 : path[collisionInd])];
}

function soldier_execute_move(frTileInst, toTilePos, dir){
	
	if (dir == undefined) dir = Dir.up;

	// move to the pushed back tile (not  changing x or y)]
	var fr = frTileInst, to = global.grid[toTilePos];

	var t = fr.soldier;
	fr.soldier = -1;
	to.soldier = t;
	
	t.lastMoved = global.turn;
	t.tileInst = to;

	with(to.soldier) direction = dir;
	send_buffer(BufferType.soldierMoved, array(frTileInst.pos, toTilePos, dir));

	if (global.edit || network_my_turn()) update_fog();
	else {
		update_enemy_outline();
		
		// not your turn and your troop gets moved
		// only happens in tank_m special event
		if (to.soldier.team == global.playas){
			global.turn++;
			update_fog();
			global.turn++;
		}
	}
}


function exchange_hut_spawn_position(originHutPosition, newSpawnPosition){

	var relatedHut = global.grid[originHutPosition].hut,
		newSpawnTile = global.grid[newSpawnPosition];

	newSpawnTile.originHutPos = global.grid[relatedHut.spawnPos].originHutPos;
	global.grid[relatedHut.spawnPos].originHutPos = -1;
	relatedHut.spawnPos = newSpawnTile.pos;

	send_buffer(BufferType.changeHutPosition, array(originHutPosition, newSpawnPosition));

}
