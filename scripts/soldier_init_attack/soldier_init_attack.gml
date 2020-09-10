function soldier_init_attack() {
	var found = false;



	if (global.selectedSoldier != -1){

		var p = pos;
	

		with (global.selectedSoldier.soldier){
			if (can){
				
				// soldier_erase_attack();
				
				poss_attacks = get_tiles_from_euclidean(p, attack_range, true); //get_tiles_from(p, attack_range, 1, false);
				for (var i=0; i<array_length(poss_attacks); i++)
					with(poss_attacks[i]) {
						var team = (tower==-1 ? (soldier==-1 ? hut.team : soldier.team) : tower.team );
						if (id != global.selectedSoldier && team != other.team ){
							possible_attack = true;
							found  = true;
						}
					}
			}
		}



	}

	return found;


}
