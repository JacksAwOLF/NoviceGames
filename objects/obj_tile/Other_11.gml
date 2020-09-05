/// @description Insert description here
// You can write your code in this editor

// if mouse in and left is pressed down, we change the tiles if neccessary

if (edit) {
	switch(global.changeSprite){
		case spr_tile_border:
		case spr_tile_flat:
		case spr_tile_ocean:
		case spr_tile_mountain:
			sprite_index = global.changeSprite;
			elevation = global.elevation[get_tile_type(id)];
		
			break;
		
		case spr_tile_road:
			if (mouseIn && !preMouseIn) road = !road;
			break;
	}
}
