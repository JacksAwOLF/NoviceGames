/// @description handle double click event

debug("double clicked tile ", pos);

//exit;
// clear the selected soldier things if this block is not a possible move or attack
if (global.selectedSoldier != -1){

	
	// move block (not self)
	if (possible_move) {
		
		
		
		var path = [];
		while (!ds_stack_empty(global.selectedPathpointsStack)) {
			var cur = ds_stack_pop(global.selectedPathpointsStack);
			
			cur[0].possible_path = 0;
			cur[0].possible_pathpoint = false;
			path[array_length_1d(path)] = cur[0];
		}
		
			
		with (global.selectedSoldier.soldier){	
				
			if (array_length_1d(path)>=1 ) {
					
				if (array_length_1d(path) > 1) can = false;
					
				var i;
				for (i = array_length_1d(path)-2; i>=0; i--)
					if (path[i].soldier!=-1 && path[i] != global.selectedSoldier) break;	
				
				// clear fog if encountered soldier (stuck and  can't move)
				if (i != -1){
					path[i].hide_soldier = false;
					error = true;
				}
					
				// if you dont get stuck, move and change direction
				if (i != array_length_1d(path)-2){
				
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
				
					// move to the pushed back tile (not  changing x or y)
					if (error) i++;
					if (path[i+1] != global.selectedSoldier){
						path[i+1].soldier = global.selectedSoldier.soldier;											
						global.selectedSoldier.soldier = -1;
						global.selectedSoldier = path[i+1];
						update_fog();
					}
						
					
					//clear fog if encountered soldier  (actually moved)
					if (i != -1) path[i].hide_soldier = false;
					
				}
			}
			
		}
			
	}
				
	
	
	
	erase_blocks(true);
	global.selectedSoldier = -1;
}