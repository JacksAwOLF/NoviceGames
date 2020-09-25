/// @function Destroys the soldier at pos
/// @param pos
function destroy_soldier(pos) {
	with (global.grid[pos]){
		if (soldier != -1){
			with(soldier) instance_destroy();
			soldier = -1;
			update_fog();
		}
	}
}


/// @function Initialize the global soldier variables
/// @param soldierObjId
function init_global_soldier_vars(soldierId){
	with(soldierId){
		var type = get_soldier_type_from_sprite(sprite_index);
		attack_range = global.attack_range[class,type];
		max_health = global.max_health[class,type];
		max_damage = global.max_damage[class,type];
		vision = global.vision[class];
	}
}

/// @function Creates a soldier with sprite sind at position pos
/// @param sind
/// @param pos
/// @param [fromHut=false]
/// @param [updateFog=true]
function create_soldier(sind, pos, fromHut, updateFog) {

	if (fromHut == undefined) fromHut = false;
	if (updateFog == undefined) updateFog = true;
		
	with (global.grid[pos]){
		if (soldier == -1){
			soldier = instance_create_depth(x,y,0,obj_infantry);
			with(soldier){
				sprite_index = sind;
				team = get_team(sprite_index);
			}
			
			send_buffer(BufferDataType.soldierCreated, array(sind, pos));
			
			if (fromHut){
				var h = hut;
				with(soldier){
					class = h.soldier_class
					init_global_soldier_vars(id);
					my_health = max_health;
					if (h.sprite_dir != -1)
						direction = h.sprite_dir;
					h.steps = 0;
					just_from_hut = true;
				}
			}
			
			if (updateFog) update_fog();
				
		}
	}
}



/// @function actually execute an attack
function soldier_execute_attack(frTilePos, toTilePos){
	
	var fr = global.grid[frTilePos], to = global.grid[toTilePos];
	
	var attacked;
	if (to.soldier != -1) attacked = to.soldier;
	else if (to.tower != -1) attacked = to.tower;
	else attacked = to.hut;
	
	var damage = calculate_damage(fr.soldier, attacked);
	
	// process attacking from the side
	if (attacked == to.soldier && to.soldier != -1 && to.tower == -1) {
		var ohko = false, posdiff = frTilePos - toTilePos;
		if (posdiff == 1 || posdiff == -1)
			ohko = (to.soldier.direction % 180 == 0);
		if (posdiff == global.mapWidth || posdiff == -global.mapWidth)
			ohko = (to.soldier.direction == 90 || to.soldier.direction == 270);
			
		if (ohko) damage = to.soldier.my_health;
	}
	
	attacked.my_health -= damage;
	fr.soldier.can = false;
						
	if (attacked.my_health <= 0){
		
		if (attacked.object_index == obj_hut && attacked.steps == -1){
			// don't kill the hut, conquer it
			hut.soldier = fr.soldier;
			with(hut) event_user(10);
			
		} else if (attacked.object_index == obj_tower) {
			// make this tower into a teleport place
			attacked.team = (attacked.team+1)%2;
			append(global.conqueredTowers[fr.soldier.team], to);
		}
		
		else{
			
			switch(attacked.object_index){
				case obj_infantry:
					to.soldier = -1; break;
				case obj_hut:
					to.hut = -1; break;
			}
			
			instance_destroy(attacked);
			
		
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
	
	send_buffer(BufferDataType.soldierAttacked, array(frTilePos, toTilePos));

	erase_blocks(true);
	if (fr == global.selectedSoldier) global.selectedSoldier = -1;
}


function soldier_execute_move(frTilePos, toTilePos, dir){
	// move to the pushed back tile (not  changing x or y)]
	var fr = global.grid[frTilePos], to = global.grid[toTilePos];
	
	var t = fr.soldier;
	fr.soldier = -1;
	to.soldier = t;						
	

	
	with(to.soldier) direction = dir;
	send_buffer(BufferDataType.soldierMoved, array(frTilePos, toTilePos, dir));
	
	if (global.edit || network_my_turn()) update_fog();
	else {
		update_enemy_outline();
	}
}


