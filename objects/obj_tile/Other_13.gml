/// @description handle double click event

//debug("double clicked tile ", pos);

//exit;
// clear the selected soldier things if this block is not a possible move or attack
if (global.selectedSoldier != -1){
	
	if (possible_move || possible_path) {
		var path = [];
		
		for (var i = 0; i <= array_length(global.poss_paths)-2; i++)
			path[array_length(path)] = global.poss_paths[i];
			
		while (!ds_stack_empty(global.selectedPathpointsStack)) {
			var cur = ds_stack_pop(global.selectedPathpointsStack);
			cur[0].possible_path = 0;
			cur[0].possible_pathpoint = false;
			path[array_length(path)] = cur[0];
		}
		
		
		with (global.selectedSoldier.soldier){	
			if (array_length(path)>=1 ) {
					
				// if didn't clicked myself again (didn't deselect)
				if (array_length(path) > 1) {
					can -= moveCost;
				//	debug(can, moveCost);
				}
				
				var i; // i is index of first soldier encountered or  -1 of none
				var moveHereCost = 0;
				for (i = array_length(path)-2; i>=0; i--){
					if (path[i].soldier!=-1 && path[i] != global.selectedSoldier) break;	
					moveHereCost += global.energy[get_soldier_type(id)][get_tile_type(path[i])];
				}
				
				move_range -= moveHereCost;
				
				
				
				
				// clear fog if encountered soldier (stuck and  can't move)
				if (i != -1){
					path[i].hide_soldier = false;
					error = true;
				}
				
				
				// calculate direction  assuming you arrived  
				//  at  the blocked  tile then  was pushed back
				if (error) i--;
				var diff = path[i+1] - path[i+2];
				switch (diff) {
					case 1: direction = 270; break;
					case -1: direction = 90; break;
					case global.mapWidth: direction = 180; break;
					default: direction = 0;
				}
					
				if (error) i++;
				
				
				soldier_execute_move(global.selectedSoldier.pos,  path[i+1].pos, direction);
				global.selectedSoldier = path[i+1];
				
				//clear fog if encountered soldier  (actually moved)
				if (i != -1) path[i].hide_soldier = false;
				
			}
			
		}
			
	}
	
	
	erase_blocks(true);
	global.selectedSoldier = -1;
	global.displayTileInfo = id;
}


// double click on a hut while there is no global selected soldier
else if (hut != -1){
	// chagne auto state
	hut.auto = !hut.auto;
}