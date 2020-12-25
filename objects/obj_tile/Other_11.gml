/// @description left press
// You can write your code in this editor

// if mouse in and left is pressed down, we change the tiles if neccessary

if (edit) {
	switch(global.changeSprite){
		case spr_tile_road:
			if (mouseIn && !preMouseIn) road = !road;
			break;
			
		case spr_tile_border:
		case spr_tile_flat:
		case spr_tile_rough:
		case spr_tile_mountain:
			sprite_index = global.changeSprite;
			elevation = global.elevation[get_tile_type(id)];
			break;
			
		case spr_tile_ocean:	
			var list = ds_list_create();
			var n = collision_circle_list(mouse_x, mouse_y, 64, obj_tile, false, false, list, false);
			for (var i=0; i<n; i++){
				with (list[|i]){
					sprite_index = global.changeSprite;
					elevation = global.elevation[get_tile_type(id)];
				}
			}
			ds_list_destroy(list);
			break;
		
		
	}
}
