


if (global.selectedSoldier > 0){
	
	debug(id, global.selectedSoldier, global.selectedSoldier.soldier);
	
	with (global.selectedSoldier.soldier){
		if (poss_attacks != -1){
			for (var i=1; i<array_length_1d(poss_attacks); i++)
				poss_attacks[i].possible_attack = false;
			poss_attacks = -1;
		}
	}
}
	
