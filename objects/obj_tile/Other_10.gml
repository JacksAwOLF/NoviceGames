/// @description Insert description here
// You can write your code in this editor


	
// each index of global.changeSprite[] has a different action
// on this tile


// index 0 is implemented in user event 1
enableDoubleClick = false;
		
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
	
	if (global.selectedSoldier != -1) {
		if (possible_attack && !hide_soldier) { // process attacking
			
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
		
		
		