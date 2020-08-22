/// @description Insert description here
// You can write your code in this editor




	
// each index of global.changeSprite[] has a different action
// on this tile


// index 0 is implemented in user event 1
enableDoubleClick = false;
		
// selected a soldier
if (global.changeSprite[1] != -1){
			
	// if there's a soldier here, activate the next block of if statement
	if (soldier != -1) {
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
	
	if (global.selectedSoldier != -1) {
		if (possible_attack && !hide_soldier) { // process attacking
			with(global.selectedSoldier.soldier){
				other.soldier.my_health -= calculate_damage(id, other.soldier);
				can = false;
			}
						
			if (soldier.my_health <= 0){
				instance_destroy(soldier);
				soldier = -1;
			}
			
			erase_blocks(true);
			global.selectedSoldier = -1;
			
		} else if (possible_pathpoint) { // process deselecting blue tiles
			
			var cur = ds_stack_top(global.selectedPathpointsStack), met_same = false;
			while (ds_stack_size(global.selectedPathpointsStack) > 1 &&
					(!met_same || cur[1] == 0)) {
				
				cur[0].possible_pathpoint = false;
				cur[0].possible_path -= 1;
					
				met_same |= (cur[0] == id && cur[1] > 0);
				global.pathCost -= cur[1];
				
				ds_stack_pop(global.selectedPathpointsStack);
				cur = ds_stack_top(global.selectedPathpointsStack);
			}
				
				
			erase_blocks();
			soldier_init_move(cur[0]);
			soldier_update_path(false);
			
		} // process selecting blue tiles
		else if (possible_move &&
					(global.selectedSoldier != id || ds_stack_size(global.selectedPathpointsStack) > 1)) {
			
			enableDoubleClick = true;
			possible_pathpoint = true;
				
			global.pathCost += global.dist[pos];
			for (var i = array_length_1d(global.selectedSoldier.soldier.poss_paths)-2; i >= 0; i--) {
				var val = [global.selectedSoldier.soldier.poss_paths[i], (i==0?global.dist[pos]:0)];
				
				ds_stack_push(global.selectedPathpointsStack, val);
				val[0].possible_path += 1;
			}
			
				
			erase_blocks();
			soldier_init_move(id);
			soldier_update_path(false);
			
		} // process deselecting own soldier/selecting other soldiers
		else if (!possible_path || 
			(global.selectedSoldier == id && ds_stack_size(global.selectedPathpointsStack) == 1)) {
			
			var canSelect = global.selectedSoldier != id && ds_stack_size(global.selectedPathpointsStack) == 1;
			erase_blocks(true);
			
			global.selectedSoldier = canSelect ? -1 : -2;
		}
	}
			
	
			
	// select other soldier when clicked on them
	if (global.selectedSoldier == -1) {										
		if (soldier != -1 && soldier.team == (global.turn)%2){
			if (soldier.can){
				global.selectedSoldier = id;
			
				ds_stack_clear(global.selectedPathpointsStack);
				ds_stack_push(global.selectedPathpointsStack, [global.selectedSoldier, 0]);
				global.selectedSoldier.possible_path = 1;
				
			
				soldier_init_move();
				soldier_init_attack();
			} else soldier.error = true;
		}		
	}
	
	
	if (global.selectedSoldier == -2)
		global.selectedSoldier = -1;
}
		
		