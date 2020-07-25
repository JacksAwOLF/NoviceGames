var found = false;



if (global.selectedSoldier != -1){

	var p = pos;
	

	with (global.selectedSoldier.soldier){
		if (can_attack){
				
			soldier_erase_attack();
				
			poss_attacks = get_tiles_from(p, attack_range, 1, false);
			for (var i=1; i<array_length_1d(poss_attacks); i++)
				with(poss_attacks[i]){
				
					debug("checking", id, global.selectedSoldier, soldier.team, other.team);
				
					if (id != global.selectedSoldier && soldier.team != other.team){
			
						possible_attack = true;
						found  = true;
					}
				}
		}
	}



}

return found;