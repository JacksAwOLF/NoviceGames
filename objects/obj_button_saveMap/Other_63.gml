/// @description Insert description here
// You can write your code in this editor

var i_d = ds_map_find_value(async_load, "id");

if i_d == fileName && ds_map_find_value(async_load, "status"){
	
	// update file name
	fileName = string(ds_map_find_value(async_load, "result"));	
	fileName = working_directory + fileName;
	
	save_map(Mediums.file, fileName);
}

