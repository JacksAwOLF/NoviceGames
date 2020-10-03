/// @description Returns an array path to destination in global.from array if the distance/cost is within some limit
///	@param dest_grid_id global.grid id for the destination tile
/// @param energy_limit	maximum distance/cost of the path
function get_path_to(dest, totalNrg) {

	var res = [], count = 0;
	if (global.from[dest] != -1 && global.dist[dest] <= totalNrg) {
		while (global.from[dest] != dest) {
			res[count++] = global.grid[dest];
			dest = global.from[dest];
		}

		res[count++] = global.grid[dest];
	}


	// the returned array is in reverse order, with the
	// destination being the first element
	return res;
}
