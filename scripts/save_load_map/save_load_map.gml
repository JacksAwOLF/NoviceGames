
global.saveVersion = 1;
global.global_save_order = ["saveVersion", "mapWidth", "mapHeight", "turn", "winFunction"];
// btw the first variable of an object to  save
// can't have a negative 1  value
// also if you wanna encode the frst variable of an object,
// the trigger keey hsould be the namee of the variable on the object instead
if (global.saveVersion >= 1){
	global.tiles_save_order = array(
		"sprite_index", 
		"road", 
		"originHutPos",
		array("soldier", "my_health", "sprite_index", "can", "unit_id", "tilePos", "direction", "team", "move_range", "special", "timeToLive", "discovered"), 
		array("hut", "max_health", "my_health", "steps", "limit", "soldier_sprite", "soldier_unit", "team", "sprite_dir", "spawnPos", "tilePos", "soldierSpec"),
		array("tower", "my_health", "team", "max_health", "tilePos"),
		array("beacon", "linkedSoldier", "num", "tilePos")
	);
		
	global.tiles_save_objects = array(-1, -1, -1, obj_infantry, obj_hut, obj_tower, obj_attackable);
}



function encode_save_var(data, name){
	switch(name){
		case "tilePos":
			return real(data.pos);
			break;
		case "linkedSoldier":
			data = real(data.tilePos.pos);
			return data;
			break;
		case "spriteIndex":
			return sprite_get_name(data);
			break;
			
	}
	return data;
}

function decode_save_var(data, name){
	switch(name){
		case "tilePos":
			return global.grid[data];
			break;
		case "beacon":
			if (data != -1)
				data = global.grid[data].soldier;	
			return data;
			break;
		case "spriteIndex":
			return asset_get_index(data);
			break;
	}
	return data;
}

function data_type_from_name(name){
	var dataT = buffer_f32;
	if (name == "sprite_index")
		dataT =  buffer_string;
	return dataT;
}



enum Mediums{file, buffer}

/// @param  data 
/// @param  Mediums.*** 
/// @param  dataSrc 
/// @param  nameOfdata
function save_data(data, medium, dataSrc, name){ 
	var dataT = data_type_from_name(name);
	data = encode_save_var(data, name);
	
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
	var res, dataT = data_type_from_name(name);
		
	switch (medium){
		case Mediums.file:
			res = file_text_read_string(dataSrc);
			file_text_readln(dataSrc);
			break;
		case Mediums.buffer:
			res = buffer_read(dataSrc, dataT);
			break;
	}
	
	res = real( decode_save_var(res, name) );
	
	return res;
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
			buffer_write(med, buffer_u8, BufferType.mapData);
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
	
	for (var i=0; i<global.mapWidth*global.mapHeight; i++){ //debug("reading itle", i);
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
	
	beacon_contruct_global();
			
	
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

