/// @description Insert description here
// You can write your code in this editor



	
	
// each index of global.changeSprite[] has a different action
// on this tile


// index 0 is implemented in user event 1

		
// selected a soldier
if (global.changeSprite[1] != -1){
			
	// if there's a soldier here, activate the next block of if statement
	if  (soldier != -1) {
		if (global.changeSprite[1] != spr_infantry_delete)
			global.changeSprite[1] = -1;  
		else {
			with(soldier) instance_destroy();
			soldier = -1;
			update_fog();
		}
	} 
	
	else if (global.changeSprite[1] != spr_infantry_delete)
		create_soldier(global.changeSprite[1], pos);
}

// selected a road 
else if (global.changeSprite[2] != -1) road = !road;

// selected a hut
else if (global.changeSprite[3] != -1){
	if (soldier != -1 && soldier.team==global.turn%2 && hut == -1){
		hut = instance_create_depth(x, y, -0.5, obj_hut);
		with (hut){
			soldier_sprite = other.soldier.sprite_index;
			pos = other.pos;
			limit = global.hutlimit[get_soldier_type(other.soldier)];
		}
		destroy_soldier(pos);
	}
}


// nothing selected...	
// this block handles other clicking events like moving and attacking
if (global.changeSprite[0]+global.changeSprite[1]+global.changeSprite[2]+global.changeSprite[3] == -4){		
	
	// clear the selected soldier things if this block is not a possible move or attack
	if (global.selectedSoldier != -1){

	
		// move block (not self)
		if (possible_move) {
			
			debug(global.selectedSoldier.soldier.poss_paths);
			with (global.selectedSoldier.soldier){	
				
				if (variable_instance_exists(id, "poss_paths") && poss_paths != -1) {
				
					can = false;
					var i;
					for (i = array_length_1d(poss_paths)-2; i>=0; i--)
						if (poss_paths[i].soldier!=-1 && poss_paths[i] != global.selectedSoldier) break;	
				
					// clear fog if encountered soldier
					if (i != -1) poss_paths[i].hide_soldier = false;
				
					// if you dont get stuck, move and change direction
					if (i != array_length_1d(poss_paths)-2){
				
						// direction
						var diff = poss_paths[i+1] - poss_paths[i+2];
						switch (diff) {
							case 1: direction = 270; break;
							case -1: direction = 90; break;
							case global.mapWidth: direction = 180; break;
							default: direction = 0;
						}
				
						// move
						poss_paths[i+1].soldier = global.selectedSoldier.soldier;											
						global.selectedSoldier.soldier = -1;
						global.selectedSoldier = poss_paths[i+1];
						update_fog();
						
					
						//clear fog if encountered soldier; after update_fog
						if (i != -1) poss_paths[i].hide_soldier = false;
					
						erase_blocks();
					}
				}
			
			}
			
		}
				
			
		// attack block
		else if (possible_attack && !hide_soldier){
					
			with(global.selectedSoldier.soldier){
				other.soldier.my_health -= calculate_damage(id, other.soldier);
				can = false;
			}
						
			if (soldier.my_health <= 0){
				instance_destroy(soldier);
				soldier = -1;
			}
		}
		
		erase_blocks();
		global.selectedSoldier = (id == global.selectedSoldier ? -2 : -1);
	}
			
			
			
	// select other soldier when clicked on them
	if (global.selectedSoldier == -1){										
		if (soldier != -1 && soldier.team == (global.turn)%2){
			if (soldier.can){
				global.selectedSoldier = id;
				soldier_init_move();
				soldier_init_attack();
			}
		}
	} 
	

	if (global.selectedSoldier == -2) global.selectedSoldier = -1;
			
			

	// if soldier is selected, but it can't  attack or move, deselect  it
	if (global.selectedSoldier != -1) 
		if (!global.selectedSoldier.soldier.can) 
			global.selectedSoldier = -1;
}
		
		