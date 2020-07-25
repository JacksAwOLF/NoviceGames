with(global.selectedSoldier){
	var p = pos;

	with(soldier){

		if (can_move){
			poss_moves = get_tiles_from(p, move_range, -1, true);
			for (var i=0; i<array_length_1d(poss_moves); i++)
				poss_moves[i].possible_move = true;
		} 
	
	}

}
