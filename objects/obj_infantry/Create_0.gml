/// @description Insert description here
// You can write your code in this editor

if (global.edit){
	attack_range = global.soldier_vars[Svars.attack_range];
	max_health = global.soldier_vars[Svars.max_health];
	max_damage = global.soldier_vars[Svars.max_damage];
	class = global.soldier_vars[Svars.class];
	vision = global.soldier_vars[Svars.vision]; //global.vision[class]
	my_health = max_health
}

// from deleted  object obj_soldier_parent
poss_attacks = -1;
poss_moves = -1;


team = 0;


poss_paths = 0;


error = false;					// when set to true, flash the soldier
error_count = 0;				// increment this until reaches limit
error_limit = 3;				// how many times to flash
error_wait = 5;					// how many frames per flash



event_inherited();
team = get_team(sprite_index);
