// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

global.allActions[Actions.movement] = new Action();
global.allActions[Actions.movement].processAgainIfEnd = true;

global.allActions[Actions.movement].leftClick = function(tileId) {
	
	debug("click on tile", tileId, global.selectedSoldier);
	
	with(tileId){
	
	// select soldier and init move
	if (global.selectedSoldier == -1) {
		
		var myturn =  (global.edit || network_my_turn() );
		if (soldier != -1) {
			if(soldier.team == (global.turn)%2 && myturn){
				global.selectedSoldier = soldier; 

				if (soldier.formation != -1){
					centerObjectInWindow(obj_disbandFormation, 1/4, 1/2, 0, 1/2) ;
					soldier_init_move_formation(pos);
					return true;
				}

				else if (soldier.can && soldier.move_range){
					ds_stack_clear(global.selectedPathpointsStack);
					ds_stack_push(global.selectedPathpointsStack, [global.selectedSoldier.tileInst, 0]);
					global.selectedSoldier.tileInst.possible_path = 1;
					soldier_init_move();
					return true;
				}
				
				else global.selectedSoldier = -1;
			}
		}
		
		clickInd = 0;
		return false;
	}
	
		
	// deselecting blue tiles
	if (possible_pathpoint) { 

		enableDoubleClick = true;

		var cur = ds_stack_top(global.selectedPathpointsStack), met_same = false;
		while (ds_stack_size(global.selectedPathpointsStack) > 1 &&
				(!met_same || cur[1] == 0)) {

			cur[0].possible_pathpoint = false;
			cur[0].possible_path -= 1;


			met_same |= (cur[0] == id && cur[1] > 0);
			if (!is_plane(global.selectedSoldier))
				global.pathCost -= cur[1];

			ds_stack_pop(global.selectedPathpointsStack);
			cur = ds_stack_top(global.selectedPathpointsStack);
		}


		erase_blocks();
		soldier_init_move(cur[0]);
		soldier_update_path(false);
		return true;
	} 

	// selecting blue tiles
	else if ( (possible_move ) &&
				(global.selectedSoldier.tileInst != id || ds_stack_size(global.selectedPathpointsStack) > 1)) {

		enableDoubleClick = true;
		if (global.selectedSoldier.formation == -1) {
			possible_pathpoint = true;

			if (!is_plane(global.selectedSoldier))
				global.pathCost += global.dist[pos];

			for (var i = array_length(global.poss_paths)-2; i >= 0; i--) {
				var val = [global.poss_paths[i], (i==0?global.dist[pos]:0)];

				ds_stack_push(global.selectedPathpointsStack, val);
				val[0].possible_path += 1;
			}

			erase_blocks();
			soldier_init_move(id);
			soldier_update_path(false);
			return true;
		}
	} 


	// deselecting own soldier/selecting other soldiers
	else if (!possible_path ||
		(global.selectedSoldier.tileInst == id && ds_stack_size(global.selectedPathpointsStack) == 1)) {

		var canSelect = global.selectedSoldier.tileInst != id && ds_stack_size(global.selectedPathpointsStack) == 1;
		erase_blocks(true);

		var formationCondition = (soldier != -1 && soldier.team == global.selectedSoldier.team &&
			soldier.formation != -1 && soldier.formation == global.selectedSoldier.formation);


		global.selectedSoldier = canSelect || formationCondition ? -1 : -2;
		global.displayTileInfo = id;
		
		debug("returned false, reset", global.selectedSoldier);
	}
	
	// i don't think this needs to be here anymore but just in case
	if (global.selectedSoldier == -2)
		global.selectedSoldier = -1;
	
	debug("the code is so fucked");
	return false;
	
	}
}

global.allActions[Actions.movement].doubleClick = function(tileId) {
	
	with (tileId){
	
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
		
		} 
		
		else if (possible_move || possible_path) {  
			var path = [];
			var pathpoints = [];	// store pathpoints (for recon planes)
		
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
				// if nPath == 1, user deselects own soldier
				else if (nPath > 1) {
					var moveResult = soldier_attempt_move(tileInst, path);

			 		move_range -= moveResult[0];
					if (moveResult[1] != -1) 
						moveResult[1].hide_soldier = false;
					
					can -= moveCost;
					error = false;
				}
			
			
			
			}
			
		}
	
	}
	
	erase_blocks(true);
	global.selectedSoldier = -1;
	global.selectedFormation = -1
	global.displayTileInfo = id;
	
	return false;
	}
}

/*
else if (soldier.can && soldier.move_range){
	ds_stack_clear(global.selectedPathpointsStack);
	ds_stack_push(global.selectedPathpointsStack, [global.selectedSoldier.tileInst, 0]);
	global.selectedSoldier.tileInst.possible_path = 1;

	soldier_init_move();
	soldier_init_attack();
}*/


/*
// tileId is the tile that is clicked on
function setPossibleMoves(arr, val){
	if (arr == -1) return;
	for (var i=0; i<array_length(arr); i++)
		arr[i].possible_move = val;
}


function movementProcessClick(tileId) {
	
		sold = tileId.soldier;
		if (sold != -1 && is_my_team_obj(sold))
			with(sold) if (can >= moveCost && move_range){
				can -= moveCost;
				poss_moves = get_tiles_from(
					tileInst.pos, move_range, 
					global.energy[unit_id], true,
					(is_plane(id) ? return_true : possible_move_considering_weather)
				);
				setPossibleMoves(poss_moves, true);
				other.lastClick = -1;
				global.selectedSoldier = sold;
				return true;
			}
		return false;*/
		
		/*
		
		// process double click
		if (lastClick == -1)
			lastClick = current_time;
		else if (current_time - lastClick <= 300){
			debug("double click!");
			return false;	
		}
	
		if (tileId.possible_pathpoint){
			// deselect this pathpoint and 
			// recalculate/assign poss_moves
			
		} else if (tileId.possible_move){
			// select this pathpoint and 
			// recalculate/assing poss_moves
			
		} else {
			// erase data structures and return false
			
			return false;	
		}
		
		return true;
}*/
