function save_map_to_file(argument0) {


	// make this string and just write it to the file as one string lol
	var data = string(global.mapWidth) + "\n" + string(global.mapHeight) + "\n";
	data += string(global.turn)  + "\n";


	// write all the tiles sprites and soldiers
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
				data += string(soldier.direction) +"\n";
			} else data += "-1\n";
		}
	}


	// open and wirte to the file
	var file = file_text_open_write(argument0);
	if file == -1 debug("file wont open", argument0);
	else file_text_write_string(file, data);
	file_text_close(file);


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
