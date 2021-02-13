

function ifv_m_special(){
	
	global.unit_options_active = true;
	erase_blocks(true);
	
	global.poss_moves = [];
	for (var i = -1; i <= 1; i++) {
		for (var j = -1; j <= 1; j++) {
			var curRow = getRow(global.selectedSoldier.tilePos.pos) + i;
			var curCol = getCol(global.selectedSoldier.tilePos.pos) + j;
			var curPos = getPos(curRow, curCol);
			
			if (curRow >= 0 && curRow < global.mapHeight && curCol >= 0 && curCol < global.mapWidth)
				if (global.grid[curPos].soldier == -1) {
					global.poss_moves[array_length(global.poss_moves)] = global.grid[curPos]; 
					global.grid[curPos].possible_attack = true;
				}
		}
	}
	
	global.processClick = function(tileInst) {
		create_soldier(Units.INFANTRY_S, global.selectedSoldier.team, tileInst.pos, -1);
		
		tileInst.soldier.can = 0;
		global.selectedSoldier.can = 0;
		global.selectedSoldier.special = false;
		event_perform_object(obj_map_helper, ev_keypress, vk_space);
	}
}

// suicide and give damage to an unit in the direction it is facing
function infantry_m_special() {
	
	var curSoldier = global.selectedSoldier; // needed cuz attack resets selectedSoldier
	var nextTile = next_tile_in_dir(curSoldier.tilePos.pos, curSoldier.direction);
	
	if (nextTile != -1) {
		soldier_attack_tile(curSoldier, nextTile, curSoldier.max_damage+2);
	}
	
	destroy_soldier(curSoldier, true);
	event_perform_object(obj_map_helper, ev_keypress, vk_space);
}

function tank_s_special() {
	global.unit_options_active = true;
	erase_blocks(true);
	
	soldier_init_attack(function(tilePos) {
		return (global.grid[tilePos].soldier != -1 && 
			global.grid[tilePos].soldier != global.selectedSoldier &&
			global.grid[tilePos].soldier.team == global.selectedSoldier.team);
	});
	
	global.processClick = function(tileInst) {
		tileInst.soldier.my_health = tileInst.soldier.max_health;
		global.selectedSoldier.special = false;
		
		event_perform_object(obj_map_helper, ev_keypress, vk_space);
	};
}
