

function save_map_to_file(argument0) {
	
	var file = file_text_open_write(argument0);
	if file == -1 show_error("problem opening file", false);


	// write out global variables
	for (var i = 0; i<array_length(global.global_save_order); i++)
		file_text_write_string(file, string(variable_global_get(global.global_save_order[i]))+"\n" );


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
					file_text_write_string(file, string(data)+"\n");
					
					debug("wrote out", data1, ".",name[k], "as", data);
					
				}
					
			} else file_text_write_string(file, string(data1)+"\n");
				
		}
		
	}
			
	file_text_close(file);
}

function load_tiles_from_file(file) {
	
	for (var i=0; i<global.mapWidth*global.mapHeight; i++){ // for every tile
			
		for (var j=0; j<array_length(global.tiles_save_order); j++){ // loop through the vars saved
				
			// name is either the element, or the first  eleof the array
			var name = global.tiles_save_order[j], first = name;
			if  (is_array(name)) first = name[0];
				
			var data1 = file_text_read_real(file); file_text_readln(file);
				
				
			if (is_array(name) && data1 != -1){
					
				var g = global.grid[i], xx = g.x, yy = g.y;
					
				var obj = instance_create_depth(xx, yy, 0, global.tiles_save_objects[j]);
				variable_instance_set(g, first, obj);
					
				for (var k=1; k<array_length(name); k++){ 
					if (k != 1){data1 = file_text_read_real(file); file_text_readln(file);}
					variable_instance_set(obj, name[k], data1);
				}
				
				// some variables are only updated in the cvreate event of the objects
				with(obj) event_perform_object(global.tiles_save_objects[j], ev_create, 0);
					
			} else variable_instance_set(global.grid[i], first, data1);
				
		}
	}
}


/*function get_text(){
	var data = "";
	
	for (var i=0; i<global.mapWidth * global.mapHeight; i+=1){
		with(global.grid[i]){
			data += string(sprite_index) + "\n";
			if (road) {
				data += "1\n";
			} else data += "0\n";
			if (soldier != -1){
				data += string(soldier.attack_range) + "\n";
				data += string(soldier.max_health) + "\n";
				data += string(soldier.max_damage) + "\n";
				data += string(soldier.my_health) + "\n";
				data += string(soldier.sprite_index) + "\n";
				data += string(soldier.can) + "\n";
				data += string(soldier.vision) + "\n";
				data += string(soldier.class) + "\n";
				
			} else data += "-1\n";
		}
	}
	
	if (!global.edit) 
		move = get_string_async("Send your move to opponent and enter their move: ", data);
			
	return data;
}




function get_data(){
	var res, ref = instance_find(obj_map_helper, 0);
	if (ref.readfile){
		res = real(file_text_read_real(ref.filevar));
		file_text_readln(ref.filevar);
		debug(ref.filevar, "returning", res);
	} else { 
		res = "";
		while (true){
			var c = string_char_at(ref.data,  ref.p++);
			if (c == "\n") break;
			else res += c;
		}
	}
	return real(res);
}

/// @function before calling this function, set
///		the instance data and file variable
///		reason for doing this is ugh :'(
/// @param file boolean is a file or not
function set_text(){
	
	if (!readfile) p = 0;
	
	for (var i=0; i<global.mapWidth*global.mapHeight; i++){
		with (global.grid[i]){
			sprite_index = get_data();
			
			var line = get_data();
			if (line == 1) road = true;
			
			line = get_data();
			if line == -1  continue;
			
			soldier = instance_create_depth(x, y, 0, obj_infantry);
			with soldier {
				attack_range = line
				max_health = get_data();
				max_damage = get_data();
				my_health = get_data();
				sprite_index = get_data();
				can = get_data();
				vision = get_data();
				class = get_data();
					
				vision = global.vision[class];
				team = get_team(sprite_index);
			}
			
			
		}
	}
}





function save_map_to_file(argument0) {


	// make this string and just write it to the file as one string lol
	var data = string(global.mapWidth) + "\n" + string(global.mapHeight) + "\n";
	data += string(global.turn)  + "\n";

	// write all the tiles sprites and soldiers
	data += get_text();


	// open and wirte to the file
	var file = file_text_open_write(argument0);
	if file == -1 debug("file wont open", argument0);
	else file_text_write_string(file, data);
	file_text_close(file);

}*/
