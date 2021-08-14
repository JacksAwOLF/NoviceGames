/// @description handle double click event

debug("double click event");

// clear the selected soldier things if this block is not a possible move or attack
if (global.selectedSoldier != -1){
	
	if (global.selectedSoldier.formation != -1){ 
		
		var sS = global.selectedSoldier.tileInst,
			formId = sS.soldier.formation,
			form = global.formation[formId],
			dR = getRow(pos) - getRow(sS.pos), dC = getCol(pos) - getCol (sS.pos),
			moveC = 0, n = array_length(form.tiles), moved = array_create(n, false);
		
		while (moveC < n){
			for (var i=0; i<n; i++){
				if (moved[i]) continue;
				else if (form.tiles[i] ==  -1) {
					moved[i] = true;
					moveC++;
					continue;
				}
				var tile = form.tiles[i], startPos = tile.pos,
					newPos = getPos(getRow(startPos)+dR, getCol(startPos)+dC)
				if (global.grid[newPos].soldier != -1) continue;
				
				global.formation[formId].tiles[i] = global.grid[newPos];
				++moveC; moved[i] = true;
				with(tile.soldier) can -= moveCost;
				
				soldier_execute_move(tile, newPos, tile.soldier.direction);
			}
		}
		
	} else if (possible_move || possible_path) {  
		var path = [];
		var pathpoints = [];	// store pathpoints (for recon planes)
		
		debug("wtf", global.poss_paths)
		for (var i = 0; i <= array_length(global.poss_paths)-2; i++)
			path[array_length(path)] = global.poss_paths[i];
			
		while (!ds_stack_empty(global.selectedPathpointsStack)) {
			var cur = ds_stack_pop(global.selectedPathpointsStack);
			
			path[array_length(path)] = cur[0];
			if (cur[0].possible_pathpoint || cur[0] == id)
				pathpoints[array_length(pathpoints)] = cur[0];
				
			cur[0].possible_path = 0;
			cur[0].possible_pathpoint = false;
		}
		
		
		with (global.selectedSoldier){	
			
			var nPath = array_length(path);
			
			if (is_plane(id)) {
				
				var pathSize = array_length(pathpoints);
				planePath = array_create(pathSize);
				for (var i = pathSize-1; i >= 0; i--)
					planePath[pathSize-i-1] = pathpoints[i];
				
				finalize_deployment(id);
				
				
			} 
			else if (nPath >= 1) {
				
				var gss = global.selectedSoldier;
				
				// if didn't clicked myself again (didn't deselect)
				if (nPath > 1) {
					can -= moveCost;
				}
				
				// get the index of the path where there is an enemy soldier
				var collisionInd = nPath-2;
				var moveHereCost = 0;
				while (collisionInd >= 0){ 
					var tile = path[collisionInd];
					if (tile.soldier!=-1 && tile != gss.tileInst) break;	
					moveHereCost += global.energy[unit_id][get_tile_type(tile)];
					collisionInd--;
				}
				
				move_range -= moveHereCost;
				error = false;
				var destTileInd = collisionInd + 1;
				
				if (collisionInd != -1){
					
					if (gss.special == 1 && gss.unit_id == Units.TANK_M){
					
						// move the enemy soldier out of the way
						var a = path[collisionInd+1].pos, b = path[collisionInd].pos, 
							c = next_tile_in_dir(b, get_dir_from_travel(a, b));
						if (c != -1) soldier_execute_move(path[collisionInd], c);
						
						// change the final destination tile
						destTileInd = collisionInd;
					} 
				}
				
				var dir = gss.direction;
				if (destTileInd + 1 < nPath)
					dir = get_dir_from_travel(path[destTileInd+1].pos, path[destTileInd].pos);
				soldier_execute_move(gss.tileInst, path[destTileInd].pos, dir);
				
				if (collisionInd != -1) path[collisionInd].hide_soldier = false;
			}
			
			
			
		}
			
	}
	
	
}
// double click on a hut while there is no global selected soldier
else if (originHutPos != -1){
	// chagne auto state
	global.grid[originHutPos].hut.auto = !global.grid[originHutPos].hut.auto;
}

erase_blocks(true);
global.selectedSoldier = -1;
global.selectedFormation = -1
global.selectedSpawn = -1;
global.displayTileInfo = id;
