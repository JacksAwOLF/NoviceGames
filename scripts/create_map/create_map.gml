var numHorTiles = argument0;
var numVerTiles = argument1;

global.mapWidth = argument0;
global.mapHeight = argument1;

// argument2: array of sprites of every tile, array of rows

// argument3: 2d array of -1 or array of soldier variables
/*
global.soldier_vars[0] = 2; names[0] = "move range";
global.soldier_vars[1] = 1; names[1] = "attack range";
global.soldier_vars[2] = 15; names[2] = "max health";
global.soldier_vars[3] = 8; names[3] = "max damage";

These two variables are also stored cuz:
my_health
team
*/


/*
Creates the tiles (resizes tiles to fit the view)
the tile selction at the top
saving, back, next turn button on the bottom
*/



var tb_padd = 128
var lr_padd = 64
var tile_size = min((room_height-tb_padd*2)/numVerTiles, (room_width-lr_padd*2)/numHorTiles)

var hor_spacing = 100;
var y_axis = 30;


// create the soldier modification vars on top right
var names; 
global.soldier_vars[0] = 2; names[0] = "move range";
global.soldier_vars[1] = 1; names[1] = "attack range";
global.soldier_vars[2] = 15; names[2] = "max health";
global.soldier_vars[3] = 8; names[3] = "max damage";
for (var index=array_length_1d(names)-1; index>=0; index--){
	with(instance_create_depth(room_width-(array_length_1d(names)-index)*hor_spacing, 15, 0, obj_change_var)){
		ind = index;
		text = names[index];
	}
}



// global.grid: the 2darray that represents the map grid on the battlefield
// pos: y * global.mapWidth + x
// grid[pos][0] => tile (empty, mountain, wake, forest?)
// grid[pos][1] => unit (infantry, archer, tank...)

global.selectedSoldier = -1;

var count = 0;
for (var j=0; j<numVerTiles; j+=1){
	for (var i=0; i<numHorTiles; i+=1){
		
		var p = j * numHorTiles + i;
		global.grid[p] = instance_create_depth(lr_padd+i*(tile_size), 
			tb_padd+j*(tile_size), 0, obj_tile_parent);
			
		with(global.grid[p]){
			sprite_index = argument2[count];		// draw what?
			size = tile_size;						// the size of the sprite to draw
			pos = p;								// position in global.grid
			
			t = argument3;
			
			if (t[count, 0] != -1){
				soldier = instance_create_depth(x, y, 0, obj_infantry);
				
					soldier.move_range = argument3[count, 0];
					soldier.attack_range = argument3[count, 1];
					soldier.max_health = argument3[count, 2];
					soldier.max_damage = argument3[count, 3];
					soldier.my_health = argument3[count, 4];
					soldier.team = argument3[count, 5];
				
			}
		}
		
		count++;
	}
}




// create the tile selections on the top
global.changeSprite[0] = -1;				// the selected tile sprite
global.changeSprite[1] = -1;				// the selected army sprite
var possibleTiles = array(spr_tile_flat, spr_tile_mountain, spr_tile_ocean, 
	spr_infantry, spr_infantry1);
var index = 0; var w = 0;
for (var index=0; index<array_length_1d(possibleTiles); index++){
	with(instance_create_depth(hor_spacing*(index+1), y_axis, 0, obj_selectTile_parent)){
		what = w;
		sprite_index = possibleTiles[index];
	}
	if (index == 2) w = 1;
}




// create the saving button on bottom right
with(instance_create_depth(0,0, 0, obj_button_saveMap)){
	x = room_width - sprite_width;
	y = room_height - sprite_height;
}

// back button bottom left
with(instance_create_depth(0,0,0,obj_button_backMenu)){
	y = room_height - sprite_height;
}

// next button in the middle
with (instance_create_depth(0,0,0,obj_button_nextStep)){
	x = (room_width-sprite_width)/2;
	y = room_height - sprite_height;
}



