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



/// @function Creates a soldier with sprite sind at position pos

function create_soldier(sind, pos, fromHut, updateFog) {
	
	/// @param sind
	/// @param pos
	/// @param [update]
	

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
				with(hut) with(other.soldier){
					attack_range = other.def_attack_range
					max_health = other.def_max_health
					max_damage = other.def_max_damage
					class = other.def_class
					vision = other.def_vision
					my_health = max_health;
					
					other.steps = 0;
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
		} else  {
			
			switch(attacked.object_index){
				case obj_infantry:
					to.soldier = -1; break;
				case obj_tower:
					to.tower = -1; break;
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
	
	if (global.edit || network_my_turn()) update_fog();
	
	with(to.soldier) direction = dir;
	send_buffer(BufferDataType.soldierMoved, array(frTilePos, toTilePos, dir));
}


