global.turn = 0;
global.movement = [6,2,15];
global.energy = [];
global.vision = [];

enum Soldiers {
	tanks, infantry, ifvs
};

enum Classes {
	scout, melee, range
};

global.energy[Soldiers.tanks] = [2,3,3,99];
global.energy[Soldiers.infantry] = [1,1,2,2];
global.energy[Soldiers.ifvs] = [3,5,99,99];

global.vision[Classes.scout] = 5;
global.vision[Classes.melee] = 3;
global.vision[Classes.range] = 1;

map_loaded = true;
global.q = -1;



// mapHieght and mapWidth should be already set before calling this function
// if no file is specified

if argument0 != ""{	
	var file = file_text_open_read(argument0);
	
	global.mapWidth = real(file_text_read_real(file)); file_text_readln(file);
	global.mapHeight = real(file_text_read_real(file)); file_text_readln(file);
	global.turn = real(file_text_read_real(file)); file_text_readln(file);
}

var tb_padd = 128;  // top bottom padding betweeen the buttons and the obj_tile
var lr_padd = 64;
var hor_spacing = 75;   // x distance between each button on the top row
var y_axis = 30;    // of the top row on the top
var tile_size = min((room_height-tb_padd*2)/global.mapHeight, 
	(room_width-lr_padd*2)/global.mapWidth);


// create the tile selections on the top left
global.changeSprite[0] = -1;				// the selected tile sprite
global.changeSprite[1] = -1;				// the selected army sprite
global.changeSprite[2] = -1;				// the selected things that are drawn on terrain
var possibleTiles = array(spr_tile_flat, spr_tile_mountain, spr_tile_ocean, spr_tile_border, 
	spr_infantry, spr_infantry1, spr_infantry_delete,
	spr_tile_road);
var index = 0; var w = 0;
var slctSld1 = -1, slctSld2 = -1; // instance ids for soldier select tile buttons

for (var index=0; index<array_length_1d(possibleTiles); index++){
	with(instance_create_depth(hor_spacing*(index)+hor_spacing/2, y_axis, -1, obj_selectTile)){
		what = w;
		sprite_index = possibleTiles[index];
		
		if (possibleTiles[index] == spr_infantry) slctSld1 = id;
		if (possibleTiles[index] == spr_infantry1) slctSld2 = id;
	}
	
	if (index == 3 || index == 6) w++;
	
}

// create dropdown arrow under spr_infantry button
with(instance_create_depth(slctSld1.x, y_axis+slctSld1.sprite_height, -1, obj_sprite_dropdown)) {
	binded_button = slctSld1;
	options = [spr_infantry, spr_tanks, spr_ifvs];
}

// create dropdown arrow under spr_infantry1 button
with(instance_create_depth(slctSld2.x, y_axis+slctSld2.sprite_height, -1, obj_sprite_dropdown)) {
	binded_button = slctSld2;
	options = [spr_infantry1, spr_tanks1, spr_ifvs1];
}


// create the soldier modification vars on top right
var names; 
global.soldier_vars[0] = 2; names[0] = "move range";
global.soldier_vars[1] = 1; names[1] = "attack range";
global.soldier_vars[2] = 15; names[2] = "max health";
global.soldier_vars[3] = 8; names[3] = "max damage";
global.soldier_vars[4] = 2; names[4] = "vision";
global.soldier_vars[5] = Classes.scout;

for (var index=array_length_1d(names)-1; index>=0; index--){
	with(instance_create_depth(room_width-(array_length_1d(names)-index)*hor_spacing, 16, -1, obj_change_var)){
		ind = index;
		text = names[index];
	}
}



// create the back, next, save buttons on bottom row
var xx, yy, sp_index;


// create the saving button on bottom right
sp_index = object_get_sprite(obj_button_saveMap);
xx = room_width - sprite_get_width(sp_index);
yy = room_height - sprite_get_height(sp_index);

instance_create_depth(xx, yy, -1, obj_button_saveMap);


// back button bottom left
sp_index = object_get_sprite(obj_button_backMenu);
xx = room_width - sprite_get_width(sp_index);
yy = room_height - sprite_get_height(sp_index);

instance_create_depth(0, yy, -1, obj_button_backMenu);


// bottom, middle
sp_index = object_get_sprite(obj_button_nextStep);
xx = (room_width - sprite_get_width(sp_index)) / 2;
yy = room_height - sprite_get_height(sp_index);

instance_create_depth(xx, yy, -1, obj_button_nextStep);

// bottom bar on the bottom
sp_index = object_get_sprite(obj_gui_bottom_bar);
xx = 0;
yy = room_height - sprite_get_height(sp_index);

instance_create_depth(xx, yy, -1, obj_gui_bottom_bar);
instance_create_depth(0, 0, -1, obj_gui_bottom_bar);


// create the actual tiles
// global.grid[pos]: the 2darray that represents the map grid on the battlefield
// pos: y * global.mapWidth + x
global.selectedSoldier = -1;
global.prevHoveredTiles = [-1, -1];

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
			if (line == 1) road = true;
			
			line = real(file_text_read_real(file)); file_text_readln(file);
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
				
				vision = real(file_text_read_real(file)); file_text_readln(file);
				vision = global.vision[class];
				update_team();
			}
		}
	}
}

// identifiers for click detection
global.mouseEventId = -1;
global.mouseInstanceId = -1;

update_fog();