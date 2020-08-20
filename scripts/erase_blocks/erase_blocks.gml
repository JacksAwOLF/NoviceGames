if (global.selectedSoldier > 0){
	with(global.selectedSoldier.soldier){

		if (poss_moves != -1){
			for (var i=0; i<array_length_1d(poss_moves); i++)
				poss_moves[i].possible_move = false;
			poss_moves = -1;
		}
		
		if (poss_attacks != -1){
			for (var i=1; i<array_length_1d(poss_attacks); i++)
				poss_attacks[i].possible_attack = false;
			poss_attacks = -1;
		}

	}
}

soldier_update_path(1);


	
