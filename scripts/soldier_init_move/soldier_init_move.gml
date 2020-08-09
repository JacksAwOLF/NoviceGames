if (global.selectedSoldier != -1){

// energy exhuasted to
// 0: move to road
// 1: open
// 2: rough
// 3: mountain
var movement, energy;

with(global.selectedSoldier.soldier){
	if (can_move){
		
		switch sprite_index {

			case spr_infantry: 
			case spr_infantry1:
				movement = 2;
				energy = array(1, 1, 2, 2);
				break;
			
			// more sprites add switch statements here
			
			case spr_tanks:
			case spr_tanks1:
				movement = 6;
				energy = array(2,3,3,99);
				break;
				
			case spr_ifvs:
			case spr_ifvs1:
				movement = 15;
				energy = array(3,5,99,99);
				break;
			/*
			tanks
				movement = 6;
				energy = array(2,3,3,99);
			
			ifvs
				movement = 15;
				energy = array(3,5,99,99);
			*/
			
			
			// this is just random
			default:
				movement = move_range;
				energy = array(1, 1, 2, 3);
		}
		
		
		poss_moves = get_tiles_from(global.selectedSoldier.pos, movement, -1, true, energy);
		for (var i=0; i<array_length_1d(poss_moves); i++)
			poss_moves[i].possible_move = true;
			
	}
}




}