/// @description Insert description here
// You can write your code in this editor

// some bs code to handle asynchros events
var i_d = ds_map_find_value(async_load, "id");

if i_d == hor && ds_map_find_value(async_load, "status"){
	numHorTiles = real(ds_map_find_value(async_load, "result"));
	ver = get_integer_async("How many tiles top to botton? ", 5);
}

if i_d == ver && ds_map_find_value(async_load, "status"){
	numVerTiles = real(ds_map_find_value(async_load, "result"));
	
	// initialize the map to empty tiles
	var data;
	for (var i=0; i<numHorTiles*numVerTiles; i++)
		data[i] = 0;
		
	var soldiers;
	for (var i=0; i<numHorTiles*numVerTiles; i++)
		soldiers[i, 0] = -1;
		
	// call the script
	global.mapHeight = numVerTiles
	global.mapWidth = numHorTiles
	create_map(numHorTiles, numVerTiles, data, soldiers);
}



