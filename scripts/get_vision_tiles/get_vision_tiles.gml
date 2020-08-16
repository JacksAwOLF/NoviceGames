/// @description Returns all the tiles that can be seen from the given tile & soldier
/// @param tile_id Tile with soldier to calculate vision from

// data to be stored in queue: (grid pos, leftover vision cost)
// calculate using proportions, estimate proportions by dividing each
// grid into nine, and then from each grid find the next grid it passes through
// if a line is drawn from the center of that grid to the center of destination;
// this will cause the "line drawn" to be jagged, so will be a rough estimate at most
// maybe change the # of grids to resolve some problems as well

if (global.q == -1)
	global.q = ds_queue_create();

var startx = (argument[0].pos % global.mapWidth) * 3 + 1;
var starty = floor(argument[0].pos / global.mapWidth) * 3 + 1;

var res = [];	// array of results
var cnt = 0;	// size of results


var diff = [[0,1],[0,-1],[1,0],[-1,0],[1,1],[1,-1],[-1,1],[-1,-1]];
ds_queue_enqueue(global.q, [startx, starty, 0, 0]);

// we shouldn't need a visited array
// because each node should only have one 
// incoming edge (you can only get to some node 
// through one other node)
while (!ds_queue_empty(global.q)) {
	var head = ds_queue_head(global.q);
	ds_queue_dequeue(global.q);
	
	
	var tilex = head[0];
	var tiley = head[1];
	var grid_id = floor(tiley/3)*global.mapWidth + floor(tilex/3);

	
	var sum = head[2];		// current sum of vision costs
	var num = head[3];		// number of small tiles traversed
	var dist = sqrt((tilex - startx)*(tilex - startx) + (tiley - starty)*(tiley - starty));	
	
	// move on if we cannot see the current tile
	// weighted average of vision costs per small square * distance in terms of small squares
	
	if (num != 0 && (sum/num)*dist > argument[0].soldier.vision*3)
		continue;
	if (tilex % 3 == 1 && tiley % 3 == 1)
		res[cnt++] = global.grid[grid_id];
	
	
	var len = 4;
	if (tilex == startx && tiley == starty) len = 8; // at the beginning, we check all diagonals
	else if (abs(tilex - startx) == abs(tiley - starty)) // if abs(slope) == 1, check a diagonal
		diff[len++] = [(tilex > startx ? 1 : -1), (tiley > starty ? 1 : -1)];
		
	// loop through possible differences
	// bot, up, right, left, didagonals...
	for (var i = 0; i < len; i++) {
		
		var ds = diff[i];
		var nextx = tilex + ds[0];
		var nexty = tiley + ds[1];
		var next_grid_id = floor(nexty/3)*global.mapWidth + floor(nextx/3);
		
		// if out of bounds
		if (!point_in_rectangle(nextx, nexty, 0, 0, global.mapWidth*3-1, global.mapHeight*3-1))
			continue;
			
		var xdiff = nextx - startx;
		var ydiff = nexty - starty;
		var slope = ydiff/xdiff;
		
		var ok = false;
		switch(i) {
			case 0: // if next grid is on the bot, slope has to be (-inf, -1) U (1, inf) && nextx < startx
			case 1: // if next grid is on the top, slope has to be (-inf, -1) U (1, inf) && nexty < starty
			
				ok = xdiff == 0 || slope < -1 || slope > 1;
				ok &= (i == 0 ? ydiff > 0 : ydiff < 0);
				break;
				
			case 2: // if next grid is on the right, slope has to be (-1, 1) && nextx > startx
			case 3: // if next grid is on the left, slope has to be (-1, 1) && nextx < startx
				
				ok = slope > -1 && slope < 1;
				ok &= (i == 2 ? xdiff > 0 : xdiff < 0);
				break;
				
			default: // indices 4 and above are diagonals, diff calculations, but guaranteed to be ok
				ok = true;
		}
		
	
		// if the line from (nextx,nexty) to (startx,starty)
		// doesnt pass throuch current tile, skip this
		if (!ok)
			continue;
			
		// calculate additional costs and add into queue
		var add = 1;
		if (argument[0].elevation <= global.grid[next_grid_id].elevation) {
			switch(global.grid[next_grid_id].sprite_index) {
				case spr_tile_flat: 
				case spr_tile_road:
					add = 1; break;
					
				case spr_tile_mountain: add = 2.5; break;
				case spr_tile_ocean: add = 1.5; 
			}
		}
		
		ds_queue_enqueue(global.q, [nextx,nexty,sum+add,num+1]);
	}
}

ds_queue_clear(global.q);
return res;
