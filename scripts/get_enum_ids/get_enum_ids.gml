function get_soldier_type(soldier_instance) {
	// returns index in global.energy for a given soldier instance (arg0)
	return get_soldier_type_from_sprite(soldier_instance.sprite_index);
}

function get_soldier_type_from_sprite(sprite_index) {
	switch(sprite_index) {
		case spr_infantry: 
		case spr_infantry1:
			return Soldiers.infantry;
			
		case spr_tanks:
		case spr_tanks1:
			return Soldiers.tanks;
				
		case spr_ifvs:
		case spr_ifvs1:
			return Soldiers.ifvs;
		
		default:
			return -1;
	}
}

function get_tile_type(tile) {
	//debug("tile at", tile.pos, "sprite", sprite_get_name(tile.sprite_index));
	switch (tile.sprite_index) {
		case spr_tile_flat:
			return Tiles.open;
		
		case spr_tile_mountain:
			return Tiles.mountain;
			
		case spr_tile_ocean:
			return Tiles.rough;
			
		default:
			return Tiles.other;
	}
}