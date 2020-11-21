/// @description Insert description here
// You can write your code in this editor


	
// each index of global.changeSprite[] has a different action
// on this tile


// index 0 is implemented in user event 1
enableDoubleClick = false;

if ((!global.edit || global.changeSprite == -1) && global.selectedSoldier == -1) {
	global.displayTileInfo = id;
}
// selected a soldier

if (edit) {

	switch (global.changeSprite){
	
		case spr_infantry_delete:
			if (soldier != -1) destroy_soldier(pos);
			else if (tower != -1){
				with(tower) instance_destroy();
				tower = -1;
			} else if (originHutPos != -1){
				with (global.grid[originHutPos]){
					with(hut) instance_destroy();
					hut = -1;
				}
				originHutPos = -1;
			}
			
			
			break;
	
		case spr_infantry:
		case spr_tanks:
		case spr_ifvs:
		case spr_infantry1:
		case spr_tanks1:
		case spr_ifvs1:
		case spr_motorboat:
		case spr_motorboat1:
		case spr_destroy:
		case spr_destroy1:
		case spr_seaplane:
		case spr_seaplane1:
			if (soldier == -1) {
				create_soldier(global.changeSprite,  
					pos, -1, true);
			} else global.changeSprite = -1;
			break;
		
		case spr_tile_road:
			road = !road;
			break;
	

		case spr_soldier_generate:
	
			if (hut!=-1 || tower!=-1) break;
		
			if (soldier != -1) {
				hut = instance_create_depth(x, y, 0, obj_hut);
				with (hut){
					soldier = other.soldier;
					sprite_dir = other.soldier.direction;
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
		
		
			hut.spawnPos = pos;
			originHutPos = pos;
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
	
	formationReset()
	
	if (global.selectedSoldier != -1) {
		if (possible_attack && !hide_soldier) { // process attacking
		
			soldier_execute_attack(global.selectedSoldier.pos, pos);
			global.selectedSoldier = -2;
			
		} 
		else if (possible_pathpoint) { // process deselecting blue tiles
			
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
		
		else if ( (possible_move ) && 
					(global.selectedSoldier != id || ds_stack_size(global.selectedPathpointsStack) > 1)) {
			
			
			
			enableDoubleClick = true;
			if (global.selectedSoldier.soldier.formation == -1) {
				possible_pathpoint = true;
			
				global.pathCost += global.dist[pos];
				
				for (var i = array_length(global.poss_paths)-2; i >= 0; i--) {
					var val = [global.poss_paths[i], (i==0?global.dist[pos]:0)];
				
					ds_stack_push(global.selectedPathpointsStack, val);
					val[0].possible_path += 1;
				}
			
				
				erase_blocks();
				soldier_init_move(id);
				soldier_update_path(false);
			}

		} // process deselecting own soldier/selecting other soldiers
		
		
		
		else if (!possible_path || 
			(global.selectedSoldier == id && ds_stack_size(global.selectedPathpointsStack) == 1)) {
			
			var canSelect = global.selectedSoldier != id && ds_stack_size(global.selectedPathpointsStack) == 1;
			erase_blocks(true);
			
			var formationCondition = (soldier != -1 && soldier.team == global.selectedSoldier.soldier.team &&
				soldier.formation != -1 && soldier.formation == global.selectedSoldier.soldier.formation);
			
			
			global.selectedSoldier = canSelect || formationCondition ? -1 : -2;
			global.displayTileInfo = id;

		}  
	} 
	else if (global.selectedSpawn != -1) { // teleporting huts
		if (possible_teleport) {
			exchange_hut_spawn_position(global.selectedSpawn.originHutPos, pos);
			global.selectedSpawn = -2;
			
		} else {
			
			var canReselect = global.selectedSpawn != id;
			global.selectedSpawn = canReselect ? -1 : -2;
			enableDoubleClick = true;
		}
		
		erase_blocks(true);
	}
	
	

	
	// select other soldier when clicked on them
	if (global.selectedSoldier == -1) {		
	
		var myturn =  (global.edit || network_my_turn() );
		
		
		if (soldier != -1) {
			if(soldier.team == (global.turn)%2 && myturn){
				global.selectedSoldier = id;
				
				if (soldier.formation != -1){
					
					// disband formation option
					centerObjectInWindow(obj_disbandFormation, 1/4, 1/2, 0, 1/2) ;
					
					// movement initialization for the formation
					soldier_init_move_formation(pos);
					soldier_init_attack();
				}
				
				else if (soldier.can && soldier.move_range){
					ds_stack_clear(global.selectedPathpointsStack);
					ds_stack_push(global.selectedPathpointsStack, [global.selectedSoldier, 0]);
					global.selectedSoldier.possible_path = 1;
			
					soldier_init_move();
					soldier_init_attack();
				}
				
				
			} else if ((soldier.team == global.turn % 2) != myturn && !hide_soldier) {
				soldier.display_if_enemy = !soldier.display_if_enemy;
				update_enemy_outline();
			}
		} 
		
		else if (originHutPos != -1 && global.grid[originHutPos].hut.steps!=-1 &&
				 is_my_team_sprite(global.grid[originHutPos].hut.soldier_sprite) &&
				 global.selectedSpawn == -1) {
					 
			hut_createSoldier(pos);
			hut_refreshTeleport(global.grid[originHutPos].hut);
			
			global.selectedSpawn = id;
			enableDoubleClick = true;
		}
	
		
	}
	

	
	if (global.selectedSoldier == -2)
		global.selectedSoldier = -1;
	if (global.selectedSpawn == -2)
		global.selectedSpawn = -1;
	
	update_won();
}
		

global.selectedFormation = -1;
if (global.selectedSoldier != -1 && global.selectedSoldier.soldier != -1)
	global.selectedFormation = global.selectedSoldier.soldier.formation;
		