// returns the next tile that is in the dir direction of tile pos
// -1 if the tile is off the grid
// undefined if the arrguments are bad
function next_tile_in_dir(pos, dir){
	if (pos == undefined || dir == undefined) return undefined;
	
	var curRow = getRow(pos);
	var curCol = getCol(pos);
	
	switch (dir) {
		case Dir.up:
			curRow -= 1;
			break;
		case Dir.left:
			curCol -= 1;
			break;
		case Dir.down:
			curRow += 1;
			break;
		case Dir.right:
			curCol += 1;
			break;
	}
	
	if (on_grid(curRow, curCol)) 
		return getPos(curRow, curCol);
	else return -1;
}

// get the direction if something travelled from adjacent positions 1 to 2
function get_dir_from_travel(pos1, pos2){
	if (pos1 == undefined || pos2 == undefined) return undefined;
	var dir;
	switch (pos2 - pos1) {
		case 1: dir = Dir.right; break;
		case -1: dir = Dir.left; break;
		case global.mapWidth: dir = Dir.down; break;
		default: dir = Dir.up;
	}	
	return dir;
}
