
// @function Destroys the soldier at pos
// @param soldier instance to destroy
function destroy_soldier(soldierInstance, sendPacket) {
	
	if (sendPacket == undefined) sendPacket = false;
	
	
	if (soldierInstance == -1)
		return;
		
	if (sendPacket) send_buffer(BufferType.soldierDestroyed, 
		array(soldierInstance.tileInst.pos, encode_possible_attack_objects(soldierInstance)),
		true
	);

	with (soldierInstance) {
		if (is_plane(id)) {
			bindedCarrier.bindedPlane = -1;
			if (tileInst != -1)
				remove_from_array(tileInst.planeArr, id);

			var index = ds_list_find_index(global.allPlanes[team], id);
			ds_list_delete(global.allPlanes[team], index);

		} else {
			var index = ds_list_find_index(global.allSoldiers[team], id);
			ds_list_delete(global.allSoldiers[team], index);
			removeFromFormation(formation, tileInst);

			if (!refreshFocus())
				global.shouldFocusTurn = -1;
			if (unit_id == Units.CARRIER)  {
				destroy_soldier(bindedPlane);
				instance_destroy(storedPlaneInst);
			}
			
			beacon_soldier_destroy();
			
			tileInst.soldier = -1;
		}

		instance_destroy();
		update_fog();
	}
	
}

// @function Initialize the global soldier variables; class should be set already
// @param soldierObjId
function init_global_soldier_vars(soldierId){
	with(soldierId){
		
		lastMoved = global.turn;
		
		attack_range = global.attack_range[unit_id];
		max_health = global.max_health[unit_id];
		max_damage = global.max_damage[unit_id];
		vision = global.vision[unit_id];
		if (my_health == 0) my_health = max_health;

		if (global.map_loaded) move_range = global.movement[unit_id];
		if (is_ifv(id)) moveCost = 1;
		else if (is_plane(id)) moveCost = 0;
		else moveCost = 2;
	}
}


// @function Creates a soldier from hut
// @param sind
// @param pos
// @param fromHut
// @param [updateFog=true]
// @return instance_id or -1 if failed
function create_soldier(s_unit_id, s_team, pos, fromUnitInst, updateFog, sendPacket, spec) {

	if (updateFog == undefined) updateFog = true;
	if (sendPacket == undefined) sendPacket = true;
	if (spec == undefined) spec = false;

	// create infantry instance and initialize vars
	var created_soldier = instance_create_depth(0,0,Depths.Soldiers,obj_infantry);
	with(created_soldier){
		team = s_team
		sprite_index = global.unitSprites[s_unit_id][team];
		unit_id = s_unit_id;
		tileInst = global.grid[pos];
		special = spec;
	}
	
	if (fromUnitInst != -1 && fromUnitInst.object_index == obj_hut){
		fromUnitInst.steps = 0;
	}

	init_global_soldier_vars(created_soldier);

	if (fromUnitInst != -1){
		
		var newDir = fromUnitInst.direction;
		if (variable_instance_exists(fromUnitInst, "sprite_dir"))
			newDir = fromUnitInst.sprite_dir;
		
		created_soldier.direction = newDir;
		
	} else if (!is_plane(created_soldier)) {
		with (created_soldier) {
			attack_range = global.attack_range[s_unit_id];
			max_health = global.max_health[s_unit_id];
			max_damage = global.max_damage[s_unit_id];
			vision = global.vision[s_unit_id];
			my_health = max_health;
		}
	}


	// integrate soldier into tile
	with (global.grid[pos]) {
		if (is_plane(created_soldier)) {
			add_into_array(planeArr, created_soldier);
			ds_list_add(global.allPlanes[soldier.team], created_soldier);

		} else if (soldier == -1) {
			soldier = created_soldier;
			ds_list_add(global.allSoldiers[soldier.team], soldier);

		} else {
			instance_destroy(created_soldier);
			return -1;
		}
	}


	if (updateFog) update_fog();
	
	
	var fromPos = -1;
	if (fromUnitInst != -1 && fromUnitInst.object_index == obj_hut) 
		fromPos = global.grid[fromUnitInst.spawnPos].originHutPos;
	else if (fromUnitInst != -1 && fromUnitInst.object_index == obj_infantry)
		fromPos = fromUnitInst.tileInst.pos;
	
	
	if (sendPacket){
		send_buffer(
			BufferType.soldierCreated, 
			array(
				s_unit_id, s_team, pos, fromPos, 
				encode_possible_creation_objects(fromUnitInst),
				spec
			)
		);
	}

	return created_soldier;
}

function encode_possible_creation_objects(inst){
	if (inst == -1 || inst == 65535) return -1;
	var check = array(obj_hut, obj_infantry);
	return posInArray(check, inst.object_index);
}

function decode_possible_creation_objects(tilePos, number){
	if (tilePos == -1) return -1;
	var tileInst = global.grid[tilePos];
	var check = array(tileInst.hut, tileInst.soldier);
	return check[number];
}
