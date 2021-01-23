// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
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

function infantry_m_special() {
	var curSoldier = global.selectedSoldier; // needed cuz attack resets selectedSoldier
	var curRow = getRow(curSoldier.tilePos.pos);
	var curCol = getCol(curSoldier.tilePos.pos);
	
	switch (global.selectedSoldier.direction) {
		case 0:
			curRow -= 1;
			break;
		case 90:
			curCol += 1;
			break;
		case 180:
			curRow += 1;
			break;
		case 270:
			curCol -= 1;
			break;
	}
	
	curSoldier.max_damage += 2;
	if (curRow >= 0 && curRow < global.mapHeight && curCol >= 0 && curCol < global.mapWidth) {
		var curPos = getPos(curRow, curCol);
		soldier_attack_tile(curSoldier, curPos);
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