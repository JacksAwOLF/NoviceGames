/// @description Mouse click... generate soldier
// You can write your code in this editor


// run click event for grid if
// there is a selected sodlier that is  moving/attacking (potential to  this block)
// or there is a soldier on this block

/*
//debug("click on hut");

if (global.selectedSoldier != -1 || global.grid[pos].soldier != -1){
	with (global.grid[pos])
		event_user(0);
}

// otherwise generate soldier and stuff
else if (cur == limit && global.grid[pos].soldier == -1 && get_team(soldier_sprite) == global.turn%2){
	create_soldier(soldier_sprite, pos);
	cur = 0;
	
	// restore snapshot  default variables
	with(global.grid[pos].soldier){
		attack_range = other.def[Svars.attack_range]
		max_health = other.def[Svars.max_health]
		max_damage = other.def[Svars.max_damage]
		class = other.def[Svars.class]
		vision = other.def[Svars.vision]
	}
	
}*/