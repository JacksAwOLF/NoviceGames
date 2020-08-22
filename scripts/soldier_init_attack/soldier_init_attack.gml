function soldier_init_attack() {
	var found = false;



	if (global.selectedSoldier != -1){

		var p = pos;
	

		with (global.selectedSoldier.soldier){
			if (can){
				
				// soldier_erase_attack();
				
				poss_attacks = get_tiles_from(p, attack_range, 1, false);
				for (var i=1; i<array_length_1d(poss_attacks); i++)
					with(poss_attacks[i]){
						if (id != global.selectedSoldier && soldier.team != other.team){
							debug(id, " is possible attack");
							possible_attack = true;
							found  = true;
						}
					}
			}
		}



	}

	return found;


}
