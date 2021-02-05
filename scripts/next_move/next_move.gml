function next_move() {

	formationReset();

	// reset all soldiers variables
	var n = instance_number(obj_infantry);
	for (var i=0; i<n; i++)
		with(instance_find(obj_infantry, i)){
			can = defaultCan;
			move_range = global.movement[unit_id];

			if (is_my_team_sprite(sprite_index) && moveCost == 6969){
				init_global_soldier_vars(id);
			}
		}


	if (!global.edit && network_my_turn())
		send_buffer(BufferDataType.yourMove, []);

	// process moving planes
	//advance_planes();

	// deal with poison
	with (obj_tile)
		poisoned = false;
	
	var dir = [[0,1],[0,-1],[1,0],[-1,0],[0,0]];
	for (var i = 0; i < array_length(global.poison); i++) {
		var current = global.poison[i];
		if (current == -1) continue;
		
		var aboutToExpire = global.turn - current.turn > 3;
		for (var j = 0; j < 5; j++) {
			var curRow = getRow(current.pos) + dir[j][0];
			var curCol = getCol(current.pos) + dir[j][1];
			var curPos = getPos(curRow, curCol);
			
			if (curRow >= 0 && curRow < global.mapHeight && curCol >= 0 && curCol < global.mapHeight) {
				if (!aboutToExpire)
					global.grid[curPos].poisoned = true;
					
				if (global.grid[curPos].soldier != -1) {
					global.grid[curPos].soldier.my_health -= 1;
					if (global.grid[curPos].soldier.my_health <= 0)
						destroy_soldier(global.grid[curPos].soldier, false);
				}
			}
		}
		
		if (aboutToExpire)
			global.poison[i] = -1;
	}
	
	global.turn++; // relative positioning is important

	beacon_count();
		
	with(obj_hut){
		if ((!global.edit || global.hutOn) && steps!=-1 && get_team(soldier_sprite) != global.turn%2){
			steps = min(steps+1, limit)
		}
		if (auto && limit != -1 && steps == limit){
			hut_createSoldier(spawnPos);	// only creates soldier this turn
		}
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
	
	
	// updating weather
	if (global.weather == Weather.RAINY && global.turn % 2 == 1) {
		var dir = random(2*pi);
		var magnitude = (global.mapWidth + global.mapHeight) / 10;
		
		var nextX = floor(getCol(global.rain_center_pos) + magnitude*cos(dir));
		var nextY = floor(getRow(global.rain_center_pos) + magnitude*sin(dir));
		
		nextX = max(0, min(global.mapWidth-1, nextX));
		nextY = max(0, min(global.mapHeight-1, nextY));
		
		global.rain_center_pos = getPos(nextY, nextX);
		
	} else if (global.weather == Weather.SNOWY) {
		with (obj_infantry) {
			if (isActive && global.turn % 2 == lastMoved % 2 && global.turn - lastMoved >= 6) 
				my_health -= max_health / 3;
			if (my_health <= 0)
				destroy_soldier(id);
		}
			
	}
	
	update_won();
}
