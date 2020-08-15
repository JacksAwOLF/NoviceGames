// return array of obj_tile_parent that are (arg1) away from (arg0) 
// return array of tiles of shortest path from (arg0) to (arg1) within (arg2) energy

var dest = argument[0];
var nrg = argument[1];

var res = [], count = 0;
if (global.from[dest] != -1 && global.dist[dest] <= nrg) {
	while (global.from[dest] != dest) {
		res[count++] = global.grid[dest];
		dest = global.from[dest];
	}

	res[count++] = global.grid[dest];
}

return res;