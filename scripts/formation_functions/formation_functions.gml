
function checkFormationCompatibleId(tileInstance1, formationId) {
	if (tileInstance1.soldier == -1 || tileInstance1.soldier.team != global.formation[formationId].team)
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
function addIntoFormationId(tileInstance1, formationId) {
	if (formationId == -1)
		return -1;
		
	var formationSze = array_length(global.formation[formationId].tiles);
	global.formation[formationId].tiles[formationSze] = tileInstance1;
	tileInstance1.soldier.formation = formationId;
	
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
		global.formation[formationId] = { team : tileInstance1.soldier.team, 
										  tiles : [tileInstance2]};
										  
		tileInstance2.soldier.formation = formationId;
	}
	
	return addIntoFormationId(tileInstance1, formationId);
}


// remove tileInstance from formation formationId
// for now, replaces place in array with -1
// returns true if successful
function removeFromFormation(formationId, tileInstance) {
	if (tileInstance.soldier == -1 || formationId == -1 ||
		tileInstance.soldier.formation != formationId)
		return false;
	
	var formationSze = 0, lastIndex = -1;
	for (var i = 0; i < array_length(global.formation[formationId].tiles); i++) {
		if (global.formation[formationId].tiles[i] == -1)
			continue;
		else if (global.formation[formationId].tiles[i] == tileInstance)
			global.formation[formationId].tiles[i] = -1;
		else {
			formationSze++;
			lastIndex = i;
		}
	}
	
	// discard the formation if there's 
	// only one element in the formation,
	if (formationSze == 1) {
		global.formation[formationId].tiles[lastIndex].soldier.formation = -1;
		global.formation[formationId] = -1;
	}
	
	tileInstance.soldier.formation = -1;
	return true;
}