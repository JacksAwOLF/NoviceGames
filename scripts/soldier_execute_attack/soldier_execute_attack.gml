

function soldier_attack_tile(attackUnitInst, toTilePos) {
	var to = global.grid[toTilePos], attacked;

	if (to.soldier != -1) attacked = to.soldier;
	else if (to.tower != -1) attacked = to.tower;
	else attacked = to.hut;

	soldier_execute_attack(attackUnitInst, attacked);

}

// @function actually execute an attack
function soldier_execute_attack(attackerUnitInst, attacked){

	var fr = attackerUnitInst.tilePos, to = attacked.tilePos;	

	var damage = calculate_damage(attackerUnitInst, attacked);
	
	// process attacking from the side
	if (attacked == to.soldier && to.soldier != -1 && to.tower == -1) {
		var ohko = false, posdiff = fr.pos - to.pos;
		if (posdiff == 1 || posdiff == -1)
			ohko = (to.soldier.direction % 180 == 0);
		if (posdiff == global.mapWidth || posdiff == -global.mapWidth)
			ohko = (to.soldier.direction == 90 || to.soldier.direction == 270);

		if (ohko && !is_tank(attacked))
			damage = to.soldier.my_health;
	}

	attacked.my_health -= damage;
	attackerUnitInst.can -= attackerUnitInst.attackCost;
	
	
	send_buffer(
		BufferDataType.soldierAttacked, 
		array(
			attackerUnitInst.tilePos.pos, 
			to.pos, 
			encode_possible_attack_objects(attackerUnitInst),
			encode_possible_attack_objects(attacked)
		)
	);
	
	

	if (attacked.my_health <= 0){
		
		if (attacked.object_index == obj_hut && attacked.nuetral == true) {

			// conquer the hut, or destroy it (based on the attacking unit's hut limit)
			if (global.hutlimit[attackerUnitInst.unit_id] == -1) {
				instance_destroy(attacked);
				attacked.hut = -1;
			} else {
				attacked.soldier = attackerUnitInst;
				with(attacked) event_user(10);
			}

		} else if (attacked.object_index == obj_tower) {
			// if someone was teleporting to this place already
			if (to.originHutPos != -1) {
				var originGrid = global.grid[to.originHutPos];
				originGrid.hut.spawnPos = originGrid.pos;
				originGrid.originHutPos = originGrid.pos;

				to.originHutPos = -1;


			}

			// if it is a teleport location
			if (attacked.my_health + damage <= 0) {
				for (var i = 0; i < array_length(global.conqueredTowers[attacked.team]); i++) {
					if (global.conqueredTowers[attacked.team][i] == to) {
						global.conqueredTowers[attacked.team][i] = -1;
						break;
					}
				}

				to.tower = -1;
				instance_destroy(attacked);

			} else {
				// make this tower into a teleport place
				attacked.team = (attacked.team+1)%2;
				append(global.conqueredTowers[attackerUnitInst.team], to);
			}



		} //else if (object_index == )

		else{
			switch(attacked.object_index){
				case obj_infantry:
					destroy_soldier(attacked, false); 
					break;

				case obj_hut:
					global.grid[attacked.spawnPos].originHutPos = -1;
					to.hut = -1;

				default:
					instance_destroy(attacked);
			}




			if (global.edit) update_fog();

			// if you got this through a buffer,
			// then you update the fog for yourself
			else if (!network_my_turn()){
				global.turn++;
				update_fog();
				global.turn--;
			} else {
				update_enemy_outline();
			}
		}

	}

	// melee unit fixing ability
	// this is returned back to default in next_move
	else if (is_infantry(attackerUnitInst) && attacked.object_index == obj_infantry){
		if (are_tiles_adjacent(fr.pos, to.pos)) // implemented in grid_helper_functions
			attacked.moveCost = 6969;
	}
	

	erase_blocks(true);
	if (attackerUnitInst == global.selectedSoldier)
		global.selectedSoldier = -1;
}



function encode_possible_attack_objects(inst){
	var check = array(obj_infantry, obj_hut, obj_tower);
	var ind = posInArray(check, inst.object_index);
	if (ind == 0 && is_plane(inst)){
		var exist = posInArray(inst.tilePos.planeArr, inst)
		// if (exist == -1) then iddk maybe we didnt update it correclty
		ind = array_length(check) + exist;
	}
	
	return ind;
		
}

function decode_possible_attack_objects(tilePos, ind){
	var t = global.grid[tilePos];
	var check = array(t.soldier, t.hut, t.tower);
	
	if (ind < array_length(check)) 
		return check[ind];
		
	ind -= array_length(check);
	return t.planeArr[ind];
}
