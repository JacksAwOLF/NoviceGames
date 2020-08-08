if argument0 != ""{	
	var file = file_text_open_read(argument0);
	
	global.mapWidth = real(file_text_read_real(file)); file_text_readln(file);
	global.mapHeight = real(file_text_read_real(file)); file_text_readln(file);
	global.turn = real(file_text_read_real(file)); file_text_readln(file);
	
}

var rm_height = camera_get_view_height(view_get_camera(0));
var rm_width = camera_get_view_width(view_get_camera(0));


var tb_padd = 128;  // top bottom padding betweeen the buttons and the obj_tile
var lr_padd = 64;
var hor_spacing = 80;   // x distance between each button on the top row
var y_axis = 30;    // of the top row on the top
var tile_size = min((rm_height-tb_padd*2)/global.mapHeight, 
	(rm_width-lr_padd*2)/global.mapWidth);


// create the tile selections on the top left
global.changeSprite[0] = -1;				// the selected tile sprite
global.changeSprite[1] = -1;				// the selected army sprite
var possibleTiles = array(spr_tile_flat, spr_tile_mountain, spr_tile_ocean, spr_tile_border, 
	spr_infantry, spr_infantry1, spr_infantry_delete);
var index = 0; var w = 0;
for (var index=0; index<array_length_1d(possibleTiles); index++){
	with(instance_create_depth(hor_spacing*(index+1), y_axis, -1, obj_selectTile)){
		what = w;
		sprite_index = possibleTiles[index];
	}
	if (index == 3) w = 1;
}



// create the soldier modification vars on top right
var names; 
global.soldier_vars[0] = 2; names[0] = "move range";
global.soldier_vars[1] = 1; names[1] = "attack range";
global.soldier_vars[2] = 15; names[2] = "max health";
global.soldier_vars[3] = 8; names[3] = "max damage";
for (var index=array_length_1d(names)-1; index>=0; index--){
	with(instance_create_depth(rm_width-(array_length_1d(names)-index)*hor_spacing, 15, -1, obj_change_var)){
		ind = index;
		text = names[index];
	}
}



// create the back, next, save buttons on bottom row
var xx, yy, sp_index;



// create the saving button on bottom right
sp_index = object_get_sprite(obj_button_saveMap);
xx = rm_width - sprite_get_width(sp_index);
yy = rm_height - sprite_get_height(sp_index);

instance_create_depth(xx, yy, -1, obj_button_saveMap);


// back button bottom left
sp_index = object_get_sprite(obj_button_backMenu);
xx = rm_width - sprite_get_width(sp_index);
yy = rm_height - sprite_get_height(sp_index);

instance_create_depth(0, yy, -1, obj_button_backMenu);


// bottom, middle
sp_index = object_get_sprite(obj_button_nextStep);
xx = (rm_width - sprite_get_width(sp_index)) / 2;
yy = rm_height - sprite_get_height(sp_index);

instance_create_depth(xx, yy, -1, obj_button_nextStep);

sp_index = object_get_sprite(obj_gui_bottom_bar);
xx = 0;
yy = rm_height - sprite_get_height(sp_index);

instance_create_depth(xx, yy, -1, obj_gui_bottom_bar);
instance_create_depth(0, 0, -1, obj_gui_bottom_bar);


// create the actual tiles
// global.grid[pos]: the 2darray that represents the map grid on the battlefield
// pos: y * global.mapWidth + x
global.selectedSoldier = -1;
global.turn = 0;
for (var j=0; j<global.mapHeight; j+=1){
	for (var i=0; i<global.mapWidth; i+=1){
		
		var p = j * global.mapWidth + i;
		global.grid[p] = instance_create_depth(lr_padd+i*(tile_size), 
			tb_padd+j*(tile_size), 0, obj_tile);
			
		with(global.grid[p]){
			sprite_index = spr_tile_flat;
			image_xscale = tile_size / sprite_get_width(sprite_index);
			image_yscale = tile_size / sprite_get_height(sprite_index);
			
			size = tile_size;						// the size of the sprite to draw
			pos = p;								// position in global.grid
		}
		
	}
}





// if the file input is specified
// open the file and update the tile_sprites and add soldiers if neccessary


if argument0 != ""{
	for (var i=0; i<global.mapWidth*global.mapHeight; i++){
		with (global.grid[i]){
			sprite_index = real(file_text_read_real(file)); file_text_readln(file);
			var line = real(file_text_read_real(file)); file_text_readln(file);
			if line == -1  continue;
			
			soldier = instance_create_depth(x, y, 0, obj_infantry);
			with soldier {
				move_range = line;
				attack_range = real(file_text_read_real(file)); file_text_readln(file);
				max_health = real(file_text_read_real(file)); file_text_readln(file);
				max_damage = real(file_text_read_real(file)); file_text_readln(file);
				my_health = real(file_text_read_real(file)); file_text_readln(file);
				sprite_index = real(file_text_read_real(file)); file_text_readln(file);
				can_move = real(file_text_read_real(file)); file_text_readln(file);
				can_attack = real(file_text_read_real(file)); file_text_readln(file);
				update_team();
			}
		}
	}
}

global.mouseEventId = -1;
global.mouseInstanceId = -1;