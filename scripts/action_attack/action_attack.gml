// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

global.allActions[Actions.attack] = new Action();
global.allActions[Actions.attack].processAgainIfEnd = true;

global.allActions[Actions.movement].selectedSoldier = -1;

global.allActions[Actions.attack].leftClick = function(tileId){
	with(tileId){
	
	// select soldier and init attack
	/*if (global.selectedSoldier == -1) {
		var myturn =  (global.edit || network_my_turn() );
		if (soldier != -1) {
			if(soldier.team == (global.turn)%2 && myturn){
				if (soldier.can && soldier.move_range){
					global.selectedSoldier = soldier;
					soldier_init_attack();
					return true;
				}
			}
		}
		return false;
	}*/
	
	// process attacking
	if (global.selectedSoldier != -1) {
		debug("process attack", possible_attack, hide_soldier);
		
		if (possible_attack && !hide_soldier) { // process attacking
			
			// put unitLockedOn in finalize deployment
			if (global.selectedSoldier.unit_id == Units.BOMBER || 
				global.selectedSoldier.unit_id == Units.FIGHTER) {
				
				//global.selectedSoldier.unitLockedOn = soldier;   
				
				finalize_deployment(global.selectedSoldier, pos);

			} else if (global.unit_options_active && global.processClick != -1) {
				// override regular attack processing (currently used by special units)
				global.processClick(id);
			} 
			else {
				debug("actually attack");
				soldier_attack_tile(global.selectedSoldier, pos);
			}
			
			global.selectedSoldier = -1;

		}
	
	}
	
	return false;
	}
}


