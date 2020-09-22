
enum Mediums{file, buffer}

/// @param  data 
/// @param  Mediums.*** 
/// @param  dataSrc 
/// @param  nameOfdata
function save_data(data, medium, dataSrc, name){
	var dataT = buffer_f32;
	if (global.saveVersion >= 6 && name == "sprite_index"){
		data = sprite_get_name(data);
		dataT =  buffer_string;
	}
	
	switch (medium){
		case Mediums.file:
			file_text_write_string(dataSrc, string(data)+"\n" );
			break;
		case Mediums.buffer:
			buffer_write(dataSrc, dataT, data);
			break;
	}
}


/// @param  Mediums.***
/// @param  dataSrc
/// @param  nameOfData
function get_data(medium, dataSrc, name){
	var res, dataT = buffer_f32;
	if (global.saveVersion >= 6 && name == "sprite_index")
		dataT = buffer_string;
		
	switch (medium){
		case Mediums.file:
			res = file_text_read_string(dataSrc);
			file_text_readln(dataSrc);
			break;
		case Mediums.buffer:
			res = buffer_read(dataSrc, dataT);
			break;
	}
	
	if (global.saveVersion >= 6 && name == "sprite_index")
		res = asset_get_index(res);
	
	return real(res);
}




/// @param Mediums.***
/// @param {string} filenameOrNothing
function save_map(saveAs, helpData) {
	
	var med=-1;
	switch (saveAs){
		case Mediums.file:
			med = file_text_open_write(helpData); break;
		case Mediums.buffer:
			med = buffer_create(1600, buffer_grow, 1); 
			buffer_write(med, buffer_u8, BufferDataType.mapData);
			break;
	}

	if med < 0 show_error("problem opening save medium", false);

	// write out global variables
	for (var i = 0; i<array_length(global.global_save_order); i++){
		var name = global.global_save_order[i];
		save_data(variable_global_get(name), saveAs, med, name);
	}


	// write all the tiles and their objects on the tiles
	for (var i=0; i<global.mapWidth * global.mapHeight; i+=1){
		for (var j=0; j<array_length(global.tiles_save_order); j++){
			var name = global.tiles_save_order[j], first = name;
			if  (is_array(name)) first = name[0];
			var data1 = real(variable_instance_get(global.grid[i], first));
			
			if  (is_array(name) && data1 != -1){
				for (var k=1; k<array_length(name); k++){
					var data = real(variable_instance_get(data1, name[k]))
					save_data(data, saveAs, med, name[k]);
				}
			} else save_data(data1, saveAs, med, first);
		}
	}
	
	
	switch (saveAs){
		case Mediums.file:
			file_text_close(med);
			break;
		case Mediums.buffer:
			buffer_write(med, buffer_u8, (global.playas+1)%2);
			network_send_packet(helpData, med, buffer_get_size(med));
			buffer_delete(med);
			break;
	}
}



/// @param Mediums.***
/// @param dataSrc
function load_global_vars(medium, dataSrc){
	if dataSrc != undefined
		for (var i = 1; i<array_length(global.global_save_order); i++){ 
			var name = global.global_save_order[i];
			var d = get_data(medium, dataSrc, name);
			variable_global_set(name, real(d));
		}
}



/// @param Mediums.***
/// @param dataSrc
function load_tiles(medium, dataSrc) {
	
	if dataSrc != undefined
	
	for (var i=0; i<global.mapWidth*global.mapHeight; i++){ // for every tile
		for (var j=0; j<array_length(global.tiles_save_order); j++){ // loop through the vars saved
				
			// name is either the element, or the first  eleof the array
			var name = global.tiles_save_order[j], first = name, data1;
			if  (is_array(name)) first = name[0];
			var data1 = get_data(medium, dataSrc, first);
				
				
			if (is_array(name) && data1 != -1){
					
				var g = global.grid[i], xx = g.x, yy = g.y
				var obj = instance_create_depth(xx, yy, 0, global.tiles_save_objects[j]);
				variable_instance_set(g, first, obj);
					
				for (var k=1; k<array_length(name); k++){ 
					if (k != 1) data1 = get_data(medium, dataSrc, name[k]);
					variable_instance_set(obj, name[k], data1);
				}
				
				if (first == "soldier")
					init_global_soldier_vars(obj);
					
			} else variable_instance_set(global.grid[i], first, data1);
			
		}
	}
	
	switch (medium){
		case Mediums.file:
			if dataSrc != undefined file_text_close(dataSrc);
			break;
		case Mediums.buffer:
			global.playas = buffer_read(dataSrc, buffer_u8);
			// the buffer is deleted in read_buffer code
			break;
	}
}

