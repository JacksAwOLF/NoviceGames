
function poison_update(subtract_health){
	with (obj_tile)
		poisoned = false;
	
	
	var dir = [[0,1],[0,-1],[1,0],[-1,0],[0,0]];
	for (var i = 0; i < array_length(global.poison); i++) {
		var current = global.poison[i];
		if (current == -1) continue;
		
		
		
		var aboutToExpire = global.turn - current.turn > 3;
		for (var j = 0; j < 5; j++) {
			var curRow = getRow(current.pos) + dir[j][0];
			var curCol = getCol(current.pos) + dir[j][1];
			var curPos = getPos(curRow, curCol); 
			
			if ( on_grid(curRow, curCol) ) {
				
				if (!aboutToExpire)
					global.grid[curPos].poisoned = true;
					
				if (global.grid[curPos].soldier != -1 && subtract_health) {
					global.grid[curPos].soldier.my_health -= 1;
					if (global.grid[curPos].soldier.my_health <= 0)
						destroy_soldier(global.grid[curPos].soldier, false);
				}
			}
		}
		
		if (aboutToExpire)
			global.poison[i] = -1;
	}
}

function poison_add(attackerUnitInst, tilePosition){
	if (attackerUnitInst.unit_id == Units.INFANTRY_R && attackerUnitInst.special) {
		add_into_array(global.poison, {turn: global.turn, pos: tilePosition});
		poison_update(false);
	}
}



function poison_set_sprite(scale){
	if (poisoned){
		draw_sprite_stretched_ext(spr_pink, 0, x, y, size, size, c_white, 1);
	}
}