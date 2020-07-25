/// @description Insert description here
// You can write your code in this editor

var i_d = ds_map_find_value(async_load, "id");

if i_d == fileName && ds_map_find_value(async_load, "status"){
	
	// update file name
	fileName = string(ds_map_find_value(async_load, "result"));
	fileName = working_directory + fileName;
	show_debug_message("writing to: " + string(fileName));
	
	
	
	// make this string and just write it to the file as one string lol
	data = string(global.mapWidth) + "\n" + string(global.mapHeight) + "\n";
	
	// write all the tiles sprites
	for (var i=0; i<instance_number(obj_tile_parent); i+=1){
		with(instance_find(obj_tile_parent, i)){
			other.data += string(sprite_index) + "\n";
		}
	}
	
	// write all the soldiers on the tiles
	for (var i=0; i<instance_number(obj_tile_parent); i+=1){
		with(instance_find(obj_tile_parent, i)){
			if (soldier != -1){
/*
move_range = global.soldier_vars[0];
attack_range = global.soldier_vars[1];
max_health = global.soldier_vars[2];
max_damage = global.soldier_vars[3];

These two variables are also stored cuz:
my_health
team
*/
				other.data += string(soldier.move_range) + "\n";
				other.data += string(soldier.attack_range) + "\n";
				other.data += string(soldier.max_health) + "\n";
				other.data += string(soldier.max_damage) + "\n";
				other.data += string(soldier.my_health) + "\n";
				other.data += string(soldier.team) + "\n";

			} else other.data += "-1\n";
		}	
	}
	
	
	
	// write to file
	file = file_text_open_write(fileName);
	
	if file == -1 {
		debug("file wont open", fileName);
	}
	
	file_text_write_string(file, data);
	file_text_close(file);
	
	debug("just wrote out", data);
}

