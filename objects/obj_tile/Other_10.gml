/// @description Insert description here
// You can write your code in this editor
	
	
// each index of global.changeSprite[] has a different action
// on this tile


// index 0 is implemented in user event 1

		
// selected a soldier

debug("enter0")

if (edit && global.changeSprite[1] != -1){
			
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
else if (edit && global.changeSprite[2] != -1) road = !road;

// selected a hut
else if (edit && global.changeSprite[3] != -1){
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
if (!edit || global.changeSprite[0]+global.changeSprite[1]+global.changeSprite[2]+global.changeSprite[3] == -4){		
	
	// clear the selected soldier things if this block is not a possible move or attack
	if (global.selectedSoldier != -1){

	
		// move block (not self)
		if (possible_move) {
			debug("trying to  move to", pos);
			
			with (global.selectedSoldier.soldier){	
				
				debug("posspath", poss_paths);
				
				if (variable_instance_exists(id, "poss_paths") && poss_paths != -1
					&& array_length_1d(poss_paths)>=1 ) {					
					
					if (array_length_1d(poss_paths) > 1) can = false;
					
					var i;
					for (i = array_length_1d(poss_paths)-2; i>=0; i--)
						if (poss_paths[i].soldier!=-1 && poss_paths[i] != global.selectedSoldier) break;	
				
					// clear fog if encountered soldier (stuck and  can't move)
					if (i != -1){
						poss_paths[i].hide_soldier = false;
						error = true;
					}
					
					// if you dont get stuck, move and change direction
					if (i != array_length_1d(poss_paths)-2){
				
						// calculate direction  assuming you arrived  
						//  at  the blocked  tile then  was pushed back
						if (error) i--;
						var diff = poss_paths[i+1] - poss_paths[i+2];
						switch (diff) {
							case 1: direction = 270; break;
							case -1: direction = 90; break;
							case global.mapWidth: direction = 180; break;
							default: direction = 0;
						}
				
						// move to the pushed back tile (not  changing x or y)
						if (error) i++;
						if (poss_paths[i+1] != global.selectedSoldier){
							poss_paths[i+1].soldier = global.selectedSoldier.soldier;											
							global.selectedSoldier.soldier = -1;
							global.selectedSoldier = poss_paths[i+1];
							update_fog();
						}
						
					
						//clear fog if encountered soldier  (actually moved)
						if (i != -1) poss_paths[i].hide_soldier = false;
					
					}
				}
			
			}
			
		}
				
			
		// attack block
		else if (possible_attack){
					
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
			debug("team", soldier.team, "turn", global.turn, "position", pos);
			if (soldier.can){
				global.selectedSoldier = id;
				soldier_init_move();
				soldier_init_attack();
			} else soldier.error = true;
		}
	} 
	

	if (global.selectedSoldier == -2) global.selectedSoldier = -1;

}
		
		
		


if (global.action == "playw" || global.action == "plawb")
	global.sendStr += encode(pos) + " ";
		
debug("leave0");