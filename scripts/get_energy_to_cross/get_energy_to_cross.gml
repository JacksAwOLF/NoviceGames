/// @description Returns the energy required for some soldier to cross some tile
/// @param soldier_type_id The soldier id (soldier type) required to determine energy costs
/// @param tile_id The tile instance the soldier will cross
function get_energy_to_cross() {

	if (argument_count < 2 || argument[0] == -1) return -1;

	var possible_terrain = array(spr_tile_road, spr_tile_flat, spr_tile_ocean, 
								 spr_tile_mountain, spr_tile_border);
							 
	var tileid = posInArray(possible_terrain, (argument[1].road ? spr_tile_road : argument[1].sprite_index));

	if (tileid == 4) return 99;
	var nrg = global.energy[argument[0]];
	return nrg[tileid];



}
