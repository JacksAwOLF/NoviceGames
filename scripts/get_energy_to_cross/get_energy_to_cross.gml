// how much energy it will take for soldier instance (arg0) to go onto tile instance (arg1)

if (argument_count < 2 || argument[0] == -1) return -1;

var possible_terrain = array(spr_tile_road, spr_tile_flat, spr_tile_ocean, 
							 spr_tile_mountain, spr_tile_border);
							 
var tileid = posInArray(possible_terrain, (argument[1].road ? spr_tile_road : argument[1].sprite_index));

if (tileid == 4) return 99;
var nrg = global.energy[argument[0]];
return nrg[tileid];