/// @description Insert description here
// You can write your code in this editor
	
	
// each index of global.changeSprite[] has a different action
// on this tile


// index 0 is implemented in user event 1

		
// selected a soldier

if (edit)

switch (global.changeSprite){
	
	case spr_infantry_delete:
		with(soldier) instance_destroy();
			soldier = -1;
			update_fog();
		break;
	
	case spr_infantry:
	case spr_tanks:
	case spr_ifvs:
	case spr_infantry1:
	case spr_tanks1:
	case spr_ifvs1:
		if (soldier == -1) create_soldier(global.changeSprite, pos);
		else global.changeSprite = -1;
		break;
		
	case spr_tile_road:
		road = !road;
		break;
	
	case spr_soldier_generate:
		if (soldier != -1 && soldier.team==global.turn%2 && hut == -1){
			hut = instance_create_depth(x, y, -0.5, obj_hut);
			with (hut){
				soldier_sprite = other.soldier.sprite_index;
				pos = other.pos;
				limit = global.hutlimit[get_soldier_type(other.soldier)];
			}
			destroy_soldier(pos);
		}
		break;
		
	case spr_tower:
		tower = instance_create_depth(x, y, 1, obj_tower);
		tower.team = global.turn%2;
		tower.pos  =pos;
		break;
}


// nothing selected...	
// this block handles other clicking events like moving and attacking
if (!edit || global.changeSprite == -1){		
	
	// clear the selected soldier things if this block is not a possible move or attack
	if (global.selectedSoldier != -1){

	
		// move block (not self)
		if (possible_move) {
			
			with (global.selectedSoldier.soldier){	
				
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
			
			var attacked;
			if (soldier  != -1) attacked = soldier;
			else attacked = tower;
			
			with(global.selectedSoldier.soldier){
				attacked.my_health -= calculate_damage(id, attacked);
				can = false;
			}
						
			if (attacked.my_health <= 0){
				if ( attacked.object_index == obj_infantry ) soldier = -1;
				else tower = -1;
				instance_destroy(attacked);
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
			} else soldier.error = true;
		}
	} 
	

	if (global.selectedSoldier == -2) global.selectedSoldier = -1;

}
		
		
		