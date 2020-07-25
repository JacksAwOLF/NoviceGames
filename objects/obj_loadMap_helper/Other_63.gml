/// @description Insert description here
// You can write your code in this editor


var i_d = ds_map_find_value(async_load, "id");

if i_d == load_file {
	
	if ds_map_find_value(async_load, "status"){
	
	debug("load dialog box sugbmitted");
	
	load_file = string(ds_map_find_value(async_load, "result"));
	
	// open the file and shit
	
	file = file_text_open_read(load_file);
	
	global.mapWidth = real(file_text_read_real(file))
	file_text_readln(file);
	global.mapHeight = real(file_text_read_real(file));
	file_text_readln(file);
	
	var width = global.mapWidth;
	var height = global.mapHeight;
	
	debug("width", width, "height", height);
	
	var data;
	for (var i=0; i<width*height; i++){
		data[i] = real(file_text_read_real(file));
		file_text_readln(file);
	}
	
	debug("width", width, "height", height, "data0", data[0]);
	
	create_map(width, height, data);
	}
	
	else room_goto(rm_start_screen);
	
}

