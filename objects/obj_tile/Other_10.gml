/// @description left click
// You can write your code in this editor


debug("dingle click event")
// each index of global.changeSprite[] has a different action
// on this tile


// index 0 is implemented in user event 1
enableDoubleClick = false;

if ((!global.edit || global.changeSprite == -1) && global.selectedSoldier == -1) {
	global.displayTileInfo = id;
}


tile_changeSprite();


// this block handles events where we didn't put things on the front
if (!edit || global.changeSprite == -1){
	
	if (global.selectedSoldier != -1) {
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
			/*else if (global.selectedSoldier.unit_id == Units.FIGHTER) {
				for (var i = 0; i < array_length(planeArr); i++) {
					if (planeArr[i] != -1 && !is_my_team(planeArr[i])) {
						global.selectedSoldier.unitLockedOn = planeArr[i];
						break;
					}
				}

				finalize_deployment(global.selectedSoldier);

			} */
			else {
				soldier_attack_tile(global.selectedSoldier, pos);
			}
			
			global.selectedSoldier = -2;

		}
		else if (possible_pathpoint) { // process deselecting blue tiles

			enableDoubleClick = true;
			
			debug("{tile poss pathpoint enter");

			var cur = ds_stack_top(global.selectedPathpointsStack), met_same = false;
			while (ds_stack_size(global.selectedPathpointsStack) > 1 &&
					(!met_same || cur[1] == 0)) {

				cur[0].possible_pathpoint = false;
				cur[0].possible_path -= 1;


				met_same |= (cur[0] == id && cur[1] > 0);
				if (!is_plane(global.selectedSoldier))
					global.pathCost -= cur[1];

				ds_stack_pop(global.selectedPathpointsStack);
				cur = ds_stack_top(global.selectedPathpointsStack);
			}


			erase_blocks();
			soldier_init_move(cur[0]);
			soldier_update_path(false);
			debug("{tile poss pathpoint leave");

		} // process selecting blue tiles

		else if ( (possible_move ) &&
					(global.selectedSoldier.tileInst != id || ds_stack_size(global.selectedPathpointsStack) > 1)) {

			debug("{tile click poss_move enter")
			enableDoubleClick = true;
			if (global.selectedSoldier.formation == -1) {
				possible_pathpoint = true;

				if (!is_plane(global.selectedSoldier))
					global.pathCost += global.dist[pos];

				for (var i = array_length(global.poss_paths)-2; i >= 0; i--) {
					var val = [global.poss_paths[i], (i==0?global.dist[pos]:0)];

					ds_stack_push(global.selectedPathpointsStack, val);
					val[0].possible_path += 1;
				}

				debug("done modifying global stack")
				erase_blocks();
				debug("erased blocks")
				soldier_init_move(id);
				debug("done init move")
				soldier_update_path(false);
			}
			debug("{tile click poss_move leave")

		} // process deselecting own soldier/selecting other soldiers



		else if (!possible_path ||
			(global.selectedSoldier.tileInst == id && ds_stack_size(global.selectedPathpointsStack) == 1)) {

			var canSelect = global.selectedSoldier.tileInst != id && ds_stack_size(global.selectedPathpointsStack) == 1;
			erase_blocks(true);

			var formationCondition = (soldier != -1 && soldier.team == global.selectedSoldier.team &&
				soldier.formation != -1 && soldier.formation == global.selectedSoldier.formation);


			global.selectedSoldier = canSelect || formationCondition ? -1 : -2;
			global.displayTileInfo = id;

		}
	}






	if (global.selectedSoldier == -1) {

		var myturn =  (global.edit || network_my_turn() );

		if (global.selectedSpawn != -1) { // teleporting huts
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

		else if (soldier != -1) {
			if(soldier.team == (global.turn)%2 && myturn){
				global.selectedSoldier = soldier; 

				if (soldier.formation != -1){

					// disband formation option
					centerObjectInWindow(obj_disbandFormation, 1/4, 1/2, 0, 1/2) ;

					// movement initialization for the formation
					soldier_init_move_formation(pos);
					soldier_init_attack();
				}

				else if (soldier.can && soldier.move_range){
					ds_stack_clear(global.selectedPathpointsStack);
					ds_stack_push(global.selectedPathpointsStack, [global.selectedSoldier.tileInst, 0]);
					global.selectedSoldier.tileInst.possible_path = 1;

					soldier_init_move();
					soldier_init_attack();
				}
				
				else {
					global.selectedSoldier = -1;
				}


			} 
			else if ((soldier.team == global.turn % 2) != myturn && !hide_soldier) {
				soldier.display_if_enemy = !soldier.display_if_enemy;
				update_enemy_outline();
			}
		}

		else if (originHutPos != -1){
			with(global.grid[originHutPos].hut){

				// change auto state
				if (team == global.turn%2)
					other.enableDoubleClick = true;

				// show the possible teleport locations
				if (limit != -1 && steps == 0){
					hut_refreshTeleport(id);
					global.selectedSpawn = other.id;
				}

				// create a soldier
				if (steps != -1 && steps == limit && is_my_team_sprite(soldier_sprite) && global.selectedSpawn == -1)
					hut_createSoldier(other.pos);

			}
		}

	}



	if (global.selectedSoldier == -2)
		global.selectedSoldier = -1;
	if (global.selectedSpawn == -2)
		global.selectedSpawn = -1;

	update_won();
}


global.selectedFormation = -1;
if (global.selectedSoldier != -1)
	global.selectedFormation = global.selectedSoldier.formation;
