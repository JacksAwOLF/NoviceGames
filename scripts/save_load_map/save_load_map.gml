
enum Mediums{
	file, buffer
}

function save_data(data, medium, which){
	switch (which){
		case Mediums.file:
			file_text_write_string(medium, string(data)+"\n" );
			break;
		case Mediums.buffer:
			buffer_write(medium, buffer_s16, real(data));
			break;

	}
}

function save_map(saveAs, helpData) {
	
	var med;
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
	for (var i = 0; i<array_length(global.global_save_order); i++)
		save_data(variable_global_get(global.global_save_order[i]), med, saveAs);


	// write all the tiles and their objects on the tiles
	for (var i=0; i<global.mapWidth * global.mapHeight; i+=1){
		for (var j=0; j<array_length(global.tiles_save_order); j++){
			
			// name is either the element, or the first  eleof the array
			var name = global.tiles_save_order[j], first = name;
			if  (is_array(name)) first = name[0];
			
			// if array, -1 or instance id; otherwise,just a value
			var data1 = real(variable_instance_get(global.grid[i], first));
				
			if  (is_array(name) && data1 != -1){
				for (var k=1; k<array_length(name); k++){
					var data = real(variable_instance_get(data1, name[k]))
					save_data(data, med, saveAs);
				}
					
			} else 
			save_data(data1, med, saveAs);
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






function get_data(medium, dataSrc){
	var res = -1;
	if (medium == Mediums.file){
		res = file_text_read_real(dataSrc);
		file_text_readln(dataSrc);
	} else if (medium == Mediums.buffer)
		res = real(buffer_read(dataSrc, buffer_s16));
	else show_error("Get data medium not recognized", true);
	return res;
}



function load_global_vars(medium, dataSrc){
	global.global_save_order = ["mapWidth", "mapHeight", "turn", "saveVersion"];
	if dataSrc != undefined
		for (var i = 0; i<array_length(global.global_save_order); i++)
			variable_global_set(global.global_save_order[i], real(get_data(medium, dataSrc)));
}



function load_tiles(medium, dataSrc) {
	
	if dataSrc != undefined
	
	for (var i=0; i<global.mapWidth*global.mapHeight; i++){ // for every tile
		for (var j=0; j<array_length(global.tiles_save_order); j++){ // loop through the vars saved
				
			// name is either the element, or the first  eleof the array
			var name = global.tiles_save_order[j], first = name;
			if  (is_array(name)) first = name[0];
				
			var data1 = get_data(medium, dataSrc);
				
				
			if (is_array(name) && data1 != -1){
					
				var g = global.grid[i], xx = g.x, yy = g.y;
					
				var obj = instance_create_depth(xx, yy, 0, global.tiles_save_objects[j]);
				variable_instance_set(g, first, obj);
					
				for (var k=1; k<array_length(name); k++){ 
					if (k != 1){data1 = get_data(medium, dataSrc);}
					variable_instance_set(obj, name[k], data1);
					//debug("setting", name[k],"for", first, "to",  data1)
				}
				
				// some variables are only updated in the cvreate event of the objects
				//with(obj) event_perform_object(global.tiles_save_objects[j], ev_create, 0);
					
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

