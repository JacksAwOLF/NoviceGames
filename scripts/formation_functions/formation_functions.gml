

function disbandEntireFormation(formId){
	if (formId != -1) {
		var arr = global.formation[formId].tiles;
		for (var i =0; i<array_length(arr); i++){
			if (arr[i].soldier == -1)
				continue;
			arr[i].soldier.formation = -1;
		}

		send_buffer(BufferType.formationDelete, [formId]);

		// replace this with a ds_list in the future
		global.formation[formId] = -1;

		event_perform_object(obj_map_helper, ev_keypress, vk_space);
		formationReset();
	}
}

function checkFormationCompatibleId(tileInstance1, formationId) {
	if (tileInstance1.soldier == -1 || tileInstance1.soldier.team != global.formation[formationId].team)
		return false;
	else if (tileInstance1.soldier.formation != -1)
		return false;
		
	var compatible = false;
	
	// loop over adjacent tiles of tileInstance1 and check 
	// whether those are in the same form as tileInstance2
	for (var dx = -1; dx <= 1; dx += 1) {
		for (var dy = -global.mapWidth; dy <= global.mapWidth; dy += global.mapWidth) {
			var posToCheck = tileInstance1.pos + dx + dy;
			if (posToCheck < 0 || posToCheck >= global.mapWidth*global.mapHeight) 
				continue;
			
			var curSoldier = global.grid[posToCheck].soldier;
			compatible |= (curSoldier != -1 &&  curSoldier.formation == formationId);
		}
	}
	
	return compatible;
}

// returns whether you can add tileInstance1 into tileInstance2's formation or vice versa
function checkFormationCompatibleSoldier(tileInstance1, tileInstance2){
	// false if either of them don't have a soldier or
	// if both of them are already in a formation
	if (tileInstance1 == tileInstance2)
		return false;
	else if (tileInstance1.soldier == -1 || tileInstance2.soldier == -1)
		return false;
	else if (tileInstance1.soldier.team != tileInstance2.soldier.team)
		return false;
	else if (tileInstance1.soldier.formation != -1 && tileInstance2.soldier.formation != -1)
		return false;

	// make sure that tileInstance1 is the "formationless" soldier
	if (tileInstance2.soldier.formation == -1) {
		var swapVar = tileInstance2;
		tileInstance2 = tileInstance1;
		tileInstance1 = swapVar;
	}
	
	var compatible = false;
	
	// loop over adjacent tiles of tileInstance1 and check 
	// whether those are in the same form as tileInstance2
	for (var dx = -1; dx <= 1; dx += 1) {
		for (var dy = -global.mapWidth; dy <= global.mapWidth; dy += global.mapWidth) {
			var posToCheck = tileInstance1.pos + dx + dy;
			if (posToCheck < 0 || posToCheck >= global.mapWidth*global.mapHeight) 
				continue;
			
			var curSoldier = global.grid[posToCheck].soldier;
			compatible |= (curSoldier != -1 && curSoldier.formation != -1 &&
						   curSoldier.formation == tileInstance2.soldier.formation);
			compatible |= (posToCheck == tileInstance2.pos);
		}
	}
	
	return compatible;
}

// add tileInstance1 into formation with formationId
// returns formation id if success, -1 if fail
function addIntoFormationId(tileInstance1, formationId, sendBuffer) {
	
	if (formationId == -1)
		return -1;
		
	var formationSze = array_length(global.formation[formationId].tiles);
	global.formation[formationId].tiles[formationSze] = tileInstance1;
	tileInstance1.soldier.formation = formationId;
	tileInstance1.soldier.can = 0;
	
	// process defense bonuses
	var dir = [global.mapWidth, -global.mapWidth, 1, -1];
	for (var i = 0; i < 4; i++) {
		var gridIndex = tileInstance1.pos + dir[i];
		if (gridIndex >= 0 && gridIndex < global.mapWidth * global.mapHeight) {
			
			// adjust defense bonus if adjacent soldier is part of the same formation
			if (global.grid[gridIndex].soldier != -1 && 
				global.grid[gridIndex].soldier.formation == formationId)
					global.formation[formationId].contact_count += 1;
		}
	}
	
	if (sendBuffer==undefined || sendBuffer == true) 
		send_buffer(BufferType.formationAddTile, [tileInstance1.pos, formationId]);
		
	return formationId;
}

// returns formation index if successfully combined both into 
// one formation. otherwise returns -1
function addIntoFormationSoldier(tileInstance1, tileInstance2) {
	// false if either of them don't have a soldier or
	// if both of them are already in a formation
	if (tileInstance1 == tileInstance2)
		return -1;
	else if (tileInstance1.soldier == -1 || tileInstance2.soldier == -1)
		return -1;
	else if (tileInstance1.soldier.formation != -1 && tileInstance2.soldier.formation != -1)
		return -1;

	// make sure that tileInstance1 is the "formationless" soldier
	if (tileInstance2.soldier.formation == -1) {
		var swapVar = tileInstance2;
		tileInstance2 = tileInstance1;
		tileInstance1 = swapVar;
	}
	
	var formationId = tileInstance2.soldier.formation;
	// create a new formation if both soldiers are formationless
	if (formationId == -1) {
		formationId = array_length(global.formation);
		global.formation[formationId] = { 
											team : tileInstance1.soldier.team, 
											tiles : [tileInstance2],
											contact_count: 0,
										};
		
		tileInstance2.soldier.can = 0;
		tileInstance2.soldier.formation = formationId;
	}
	
	send_buffer(BufferType.formationCombine, [tileInstance1.pos, tileInstance2.pos]);
	return addIntoFormationId(tileInstance1, formationId, false);
}


// remove tileInstance from formation formationId
// for now, replaces place in array with -1
// returns true if successful
function removeFromFormation(formationId, tileInstance) {
	
	if (tileInstance.soldier == -1 || formationId == -1 ||
		tileInstance.soldier.formation != formationId)
		return false;
		
	tileInstance.soldier.formation = -1;
	
	var formationSze = 0, lastIndex = -1;
	for (var i = 0; i < array_length(global.formation[formationId].tiles); i++) {
		if (global.formation[formationId].tiles[i] == -1)
			continue;
		else if (global.formation[formationId].tiles[i] == tileInstance)
			global.formation[formationId].tiles[i] = -1;
		else {
			global.formation[formationId].tiles[i].flag = false;
			formationSze++;
			lastIndex = i;
		}
	}
	
	// discard the formation if there's 
	// only one element in the formation,
	if (formationSze == 1) {
		global.formation[formationId].tiles[lastIndex].soldier.formation = -1;
		global.formation[formationId] = -1;
		
	} else {
		
		var dir = [global.mapWidth, -global.mapWidth, 1, -1];
		
		var adjacentCount = 0;		// # of adjacent soldiers in same formation
		var adjacentFound = false;	// whether an adjacent soldier has been found
		var allDiscovered = true;	// whether all adjacent soldiers are connected
		
		for (var i = 0; i < 4; i++) {
			var nxtTilePos = tileInstance.pos + dir[i];
			if (nxtTilePos < 0 || nxtTilePos >= global.mapWidth * global.mapHeight)
				continue;
			else if (global.grid[nxtTilePos].soldier != -1 && 
					 global.grid[nxtTilePos].soldier.formation == formationId) {
					
				adjacentCount += 1;
				if (!adjacentFound) {	// if first adjacent tile, floodfill
					floodfill_formation(nxtTilePos, formationId);
					adjacentFound = true;
					
				} else { // otherwise, check if floodfill has reached this tile
					allDiscovered &= global.grid[nxtTilePos].flag;
				}
			} 
		}
		
		// disband formation if adjacent soldiers cannot reach each other
		if (!allDiscovered) {
			for (var i = 0; i < array_length(global.formation[formationId].tiles); i++) 
				if (global.formation[formationId].tiles[i] != -1) 
					global.formation[formationId].tiles[i].soldier.formation = -1;
			
			global.formation[formationId] = -1;
			
		} else {
			// decrease number of contact points accordingly
			global.formation[formationId].contact_count -= adjacentCount;
		}
	}
	
	// if formation disbands, reset gui
	if (global.formation[formationId] == -1)
		event_perform_object(obj_map_helper, ev_keypress, vk_space);
		
	send_buffer(BufferType.formationRemoveTile, [formationId, tileInstance.pos]);
	return true;
}


// floodfill tiles with the same formationId
// that marks tile.flag when visited
function floodfill_formation(curTilePos, formationId) {
	if (global.grid[curTilePos].flag)
		return;
		
	global.grid[curTilePos].flag = true;
	var dir = [global.mapWidth, -global.mapWidth, 1, -1];
	
	for (var i = 0; i < 4; i++) {
		var nxtTilePos = curTilePos + dir[i];
		if (nxtTilePos < 0 || nxtTilePos >= global.mapWidth * global.mapHeight)
			continue;
		else if (global.grid[nxtTilePos].soldier != -1 && 
				 global.grid[nxtTilePos].soldier.formation == formationId) 
			floodfill_formation(nxtTilePos, formationId);
	}
}

