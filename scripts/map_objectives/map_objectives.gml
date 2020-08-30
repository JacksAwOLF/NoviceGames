// map objectives should return an integer in [0,3]
// 0 -- No one has fulfilled the win condition
// 1 -- Grey has fulfilled the win condition
// 2 -- Black has fulfilled the win condition
// 3 -- Both have fulfilled the win condition
// 
// As of now, the global.win is updated in tile, init_map, and next_step

function all_huts_destroyed() {
	
	var won = 3;
	for (var i = 0; i < instance_number(obj_hut); i++)
		won &= ~(1 << ((get_team(instance_find(obj_hut, i).soldier_sprite)+ 1) % 2));
		
	return won;
}

function all_towers_destroyed() {
	
	var won = 3;
	for (var i = 0; i < instance_number(obj_tower); i++)
		won &= ~(1 << ((instance_find(obj_tower, i).team + 1) % 2));
		
	return won;
}

function all_soldiers_destroyed() {
	
	var won = 3;
	for (var i = 0; i < instance_number(obj_infantry); i++)
		won &= ~(1 << ((instance_find(obj_infantry, i).team + 1) % 2));
		
	return won;
}
