/// replaces soldier_erase_attack/move
/// @param clear_pathpoints If true, clear all pathpoints and costs

function erase_blocks() {
	if (global.selectedSoldier > 0){
		with(global.selectedSoldier.soldier){
			
			if (poss_moves != -1){
				for (var i=0; i<array_length(poss_moves); i++)
					poss_moves[i].possible_move = false;
				poss_moves = -1;
			}
		
			if (poss_attacks != -1){
				for (var i=0; i<array_length(poss_attacks); i++)
					poss_attacks[i].possible_attack = false;
				poss_attacks = -1;
			}
		
			// clear teleport zones
			for (var i=0; i<array_length(global.conqueredTowers[team]); i++)
				global.conqueredTowers[team][i].possible_teleport = false;
			for (var i=0; i<instance_number(obj_tile); i++)
				instance_find(obj_tile, i).possible_teleport = false;
		}
	}


	if (argument_count > 0 && argument[0] == true) {
		global.pathCost = 0;
		while (!ds_stack_empty(global.selectedPathpointsStack)) {
			var cur = ds_stack_pop(global.selectedPathpointsStack);
			cur[0].possible_path = 0;
			cur[0].possible_pathpoint = false;
		}
	}
	soldier_update_path(1);
}



