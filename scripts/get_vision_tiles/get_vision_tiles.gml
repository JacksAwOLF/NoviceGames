// returns all the tiles that can be seen from tile argument0

// data to be stored in queue: (grid pos, leftover vision cost)
// calculate using proportions, estimate proportions by dividing each
// grid into nine, and then from each grid find the next grid it passes through
// if a line is drawn from the center of that grid to the center of destination;
// this will cause the "line drawn" to be jagged, so will be a rough estimate at most
// maybe change the # of grids to resolve some problems as well

var q = ds_queue_create();

var startx = (argument[0].pos % global.mapWidth) * 3 + 1;
var starty = floor(argument[0].pos / global.mapWidth) * 3 + 1;

var res = [];	// array of results
var cnt = 0;	// size of results


//var vis = array_create(global.mapWidth*global.mapHeight*9);

var diff = [[0,1],[0,-1],[1,0],[-1,0],[1,1],[1,-1],[-1,1],[-1,-1]];

ds_queue_enqueue(q, [startx, starty, 0, 0]);

// we shouldn't need a visited array
// because each node should only have one 
// ingoing edge (you can only get to some node 
// through one other node)
while (!ds_queue_empty(q)) {
	
	var head = ds_queue_head(q);
	ds_queue_dequeue(q);
	
	
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
	if (tilex == startx && tiley == starty) len = 8;
	else if (abs(tilex - startx) == abs(tiley - starty))
		diff[len++] = [(tilex > startx ? 1 : -1), (tiley > starty ? 1 : -1)];
		
	// loop through possible differences
	for (var i = 0; i < len; i++) {
		
		var ds = diff[i];
		var nextx = tilex + ds[0];
		var nexty = tiley + ds[1];
		var next_grid_id = floor(nexty/3)*global.mapWidth + floor(nextx/3);
		
		// if out of bounds
		if (!point_in_rectangle(nextx, nexty, 0, 0, global.mapWidth*3-1, global.mapHeight*3-1))
			continue;
			
		
		// if line from center of (nextx, nexty) to (startx,starty) doesnt pass
		// through the current grid
		var touchleft = line_segment_intersect(startx,starty,nextx,nexty,
											   tilex-0.5,tiley-0.5,tilex-0.5,tiley+0.5);
	
		var touchright = line_segment_intersect(startx,starty,nextx,nexty,
											    tilex+0.5,tiley-0.5,tilex+0.5,tiley+0.5);
												
		var touchtop = line_segment_intersect(startx,starty,nextx,nexty,
											  tilex-0.5,tiley-0.5,tilex+0.5,tiley-0.5);	
											  
		var touchbot = line_segment_intersect(startx,starty,nextx,nexty,
											  tilex-0.5,tiley+0.5,tilex+0.5,tiley+0.5);										  
						
		
		var numtouched = touchleft + touchright + touchtop + touchbot;
		//either it touches on the corner, passes through at least two sides, or is the starting tile
		if (i < 4 && numtouched != 2 && (tilex != startx || tiley != starty))
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
		
		ds_queue_enqueue(q, [nextx,nexty,sum+add,num+1]);
	}
}

//debug("__-________OURVISION: ",argument[0].soldier.vision);

ds_queue_destroy(q);
return res;
