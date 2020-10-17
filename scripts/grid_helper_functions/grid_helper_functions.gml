// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function are_tiles_adjacent(tilePos1, tilePos2){
	var posdiff = tilePos1 - tilePos2;
	return abs(posdiff) == 1 || abs(posdiff) == global.mapWidth
}