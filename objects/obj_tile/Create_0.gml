/// @description initialize mouseIn, soldier



mouseIn = false;
soldier = -1;					// the soldier instance that is in this position


possible_path = false;			// this tile is along the current selected path
possible_move = false;			// this tile is a possible move
possible_attack = false;		// this tile is a possible attack


draw_temp_soldier = -1;			// what sprite of temporary soldier to draw


hide_soldier = true;
road = false;

// other variables are initialized in script create_map
