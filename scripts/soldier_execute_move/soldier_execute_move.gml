
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
