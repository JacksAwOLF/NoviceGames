/// @description Insert description here
// You can write your code in this editor

var i_d = ds_map_find_value(async_load, "id");

if i_d == fileName && ds_map_find_value(async_load, "status"){
	
	// update file name
	fileName = string(ds_map_find_value(async_load, "result"));
	fileName = working_directory + fileName;
	show_debug_message("writing to: " + string(fileName));
	
	// write all the tiles sprites
	data = string(global.mapWidth) + "\n" + string(global.mapHeight) + "\n";
	for (var i=0; i<instance_number(obj_tile_parent); i+=1){
		with(instance_find(obj_tile_parent, i)){
			other.data += string(sprite_index) + "\n";
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

