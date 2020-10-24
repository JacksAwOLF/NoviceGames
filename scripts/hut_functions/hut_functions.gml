// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function hut_createSoldier(tilePos){
	
	var myturn = (global.edit || network_my_turn());
	
	
	with(global.grid[tilePos]) {
		with(global.grid[originHutPos].hut){	
		
			var can = steps == limit && 
				other.soldier == -1 && 
				get_team(soldier_sprite) == global.turn%2;
		
			if (can && myturn){
				create_soldier(soldier_sprite, tilePos, other.originHutPos, true);
				steps = 0;
				
				// to help identify which soldier to teleport
				// if a possible_teleport tile is clicked in the future
			}
		}
		
		//with(hut){	
		
		//var can = steps == limit && 
		//	other.soldier == -1 && 
		//	get_team(soldier_sprite) == global.turn%2;
		//if (can && myturn){
		//	var p = other.pos;
		//	if (spawnPos != -1 && global.grid[spawnPos].soldier == -1){
		//		p = spawnPos;
		//	}
		//	create_soldier(soldier_sprite, p, other.pos, true);
		//	steps = 0;
		//}
	
	
	}
}

function hut_refreshTeleport(hutInstance) {
	for (var i=0; i<array_length(global.conqueredTowers[hutInstance.team]); i++) {
		if (global.conqueredTowers[hutInstance.team][i] != -1) {
			with(global.conqueredTowers[hutInstance.team][i])
				if (soldier == -1 && originHutPos == -1 && hutInstance.spawnPos != pos)
					possible_teleport = true;
		}
	}

	
	// if currently spawning on a teleport location, add originally location as possible teleport
	var originalHutPos = global.grid[hutInstance.spawnPos].originHutPos;
	if (hutInstance.spawnPos != originalHutPos)
		global.grid[originalHutPos].possible_teleport = true;
}