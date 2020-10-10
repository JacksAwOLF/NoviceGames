// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function hut_createSoldier(tilePos){
	
	var myturn = (global.edit || network_my_turn());
	
	
	with(global.grid[tilePos]) {
		with(global.grid[hutToSpawn].hut){	
		
			var can = steps == limit && 
				other.soldier == -1 && 
				get_team(soldier_sprite) == global.turn%2;
		
			if (can && myturn){
				create_soldier(soldier_sprite, tilePos, other.hutToSpawn, true);
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