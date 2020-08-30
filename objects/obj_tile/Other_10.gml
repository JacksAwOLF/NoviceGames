/// @description Insert description here
// You can write your code in this editor


	
// each index of global.changeSprite[] has a different action
// on this tile


// index 0 is implemented in user event 1
enableDoubleClick = false;
		
// selected a soldier

if (edit) {

	switch (global.changeSprite){
	
		case spr_infantry_delete:
			if (soldier!=-1) with(soldier) instance_destroy();
			soldier = -1;
			update_fog();
			break;
	
		case spr_infantry:
		case spr_tanks:
		case spr_ifvs:
		case spr_infantry1:
		case spr_tanks1:
		case spr_ifvs1:
			if (soldier == -1) create_soldier(global.changeSprite, pos);  //ignore warning
			else global.changeSprite = -1;
			break;
		
		case spr_tile_road:
			road = !road;
			break;
	

	case spr_soldier_generate:
	
		if (hut!=-1) break;
		
		if (soldier != -1 && soldier.team==global.turn%2){
			hut = instance_create_depth(x, y, 0, obj_hut);
			with (hut){
				//pos = other.pos;
				soldier = other.soldier;
				event_user(10);
			}
			destroy_soldier(pos);
		}
	
		else if (soldier == -1){
			hut = instance_create_depth(x, y, 0, obj_hut);
			with(hut){
				steps = -1;
				team  = -1;
			}
		}
		break;

		
		case spr_tower:
			tower = instance_create_depth(x, y, 1, obj_tower);
			tower.team = global.turn%2;
			break;
	}
}

else{    // if edit is  false
	if (client_connected(true, false) == 0) exit;
}

// nothing selected...	
// this block handles other clicking events like moving and attacking
if (!edit || global.changeSprite == -1){		
	
	if (global.selectedSoldier != -1) {
		if (possible_attack && !hide_soldier) { // process attacking
			
			soldier_execute_attack(global.selectedSoldier.pos, pos);
			
		} else if (possible_pathpoint) { // process deselecting blue tiles
			enableDoubleClick = true;
			
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
	
		var myturn =  (global.edit || network_my_turn() );
		
		
		if (soldier != -1 && soldier.team == (global.turn)%2 && myturn){
			if (soldier.can){
				global.selectedSoldier = id;
			
				ds_stack_clear(global.selectedPathpointsStack);
				ds_stack_push(global.selectedPathpointsStack, [global.selectedSoldier, 0]);
				global.selectedSoldier.possible_path = 1;
				
			
				soldier_init_move();
				soldier_init_attack();
			} else soldier.error = true;
		} 
		
		
	
		else if (hut != -1 && hut.steps!=-1) with(hut){	
		
			var  can = steps == limit && 
			other.soldier == -1 && 
			get_team(soldier_sprite) == global.turn%2;
			
			// network side
			//can = can  || (!global.edit && network_my_turn());
		
			if (can  && myturn){
				
				//debug(global.turn, get_team(soldier_sprite), sprite_get_name(soldier_sprite));
				//debug(!global.edit && network_my_turn());
				
				create_soldier(soldier_sprite, other.pos, true); // ignore the warning
				steps = 0;
	
				// restore snapshot  default variables
				/*with(global.grid[pos].soldier){
					attack_range = other.def_attack_range
					max_health = other.def_max_health
					max_damage = other.def_max_damage
					class = other.def_class
					vision = other.def_vision
					my_health = max_health;
				}*/
				
				update_fog();
			}
	
		}
	
		
		
	}
	

	
	if (global.selectedSoldier == -2)
		global.selectedSoldier = -1;
		
		
	global.won = global.winFunction();
}
		
		
		