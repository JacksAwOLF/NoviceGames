
// set only the tiles around poison target tile to be poisoned
// subtract troop's health if needed
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
					
				var s = global.grid[curPos].soldier;
				if (s != -1 && subtract_health && s.team == global.turn%2) {
					s.my_health -= 1;
					if (s.my_health <= 0)
						destroy_soldier(s, false);
				}
			}
		}
		
		if (aboutToExpire)
			global.poison[i] = -1;
	}
}


// add a poisoned position
// in sodlier_execute_attack
function poison_add(attackerUnitInst, tilePosition){
	if (attackerUnitInst.unit_id == Units.INFANTRY_R && attackerUnitInst.special) {
		add_into_array(global.poison, {turn: global.turn, pos: tilePosition});
		poison_update(false);
	}
}


// obj_tile draw event
function poison_set_sprite(scale){
	if (poisoned && !hide_soldier){
		draw_sprite_stretched_ext(spr_pink, 0, x, y, scale, scale, c_white, 0.5);
		return true;
	}
	return false;
}