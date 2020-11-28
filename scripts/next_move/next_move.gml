function next_move() {
	
	formationReset();
	
	// reset all soldiers variables
	var n = instance_number(obj_infantry);
	for (var i=0; i<n; i++)
		with(instance_find(obj_infantry, i)){
			can = 2;
			move_range = global.movement[unit_id];
			
			if (is_my_team_sprite(sprite_index) && moveCost == 6969){
				init_global_soldier_vars(id);
			}
		}
	
	
	if (!global.edit && network_my_turn())
		send_buffer(BufferDataType.yourMove, []);
		
	// process moving planes
	advance_planes();
	
	global.turn++; // relative positioning is important
	
	with(obj_hut){
		
		//debug("this hut... before", soldier, soldier_sprite, steps);
		
		if ((!global.edit || global.hutOn) && steps!=-1 && get_team(soldier_sprite) != global.turn%2){
			//debug("increase step")
			steps = min(steps+1, limit)
		}
		if (auto && limit != -1 && steps == limit){
			//debug("creating soldier");
			hut_createSoldier(spawnPos);	// only creates soldier this turn
		}
		
		//debug("this hut... after", soldier, soldier_sprite, steps);
	}

	// deselect soldiers and clear drawings
	erase_blocks(true);


	if  (global.edit){
		global.changeSprite = -1;
		global.selectedSoldier = -1;
		global.selectedSpawn = -1;
		global.selectedFormation = -1;
		update_fog();
	} 
	
	
	update_won();
}
