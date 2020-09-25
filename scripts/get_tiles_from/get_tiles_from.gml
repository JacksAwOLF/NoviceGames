


// enum Tiles {road, open, rough, mountain, others};


/// @func  get all tiles up to 'distance' away from 'startTile' with dijkstra and weighted edges described in energyTo (not including 0 distance)
/// @param startTile
/// @param distance
/// @param energyTo=1
/// @param canReachFunc=move

function get_tiles_from(start, maxDis, energyTo, canFunc) {
	
	if (energyTo == undefined) 
		energyTo = array(1,1,1,1);
	energyTo [4] = 99;
	
	if (canFunc == undefined) 
		canFunc = possible_move_tiles;

	var res = []; var count = 0;
	if (maxDis == 0) return res;

	var vis = array_create(global.mapWidth * global.mapHeight);
	vis[start] = 1;

	var dx = array(0,0,-1,1);		 
	var dy = array(-1,1,0,0);	

	var s = ds_priority_create();
	ds_priority_add(s, start, 0);

	while(!ds_priority_empty(s)){

		// get row and col and steps taken to get to this tile
		var cur = ds_priority_find_min(s);
		var steps = ds_priority_find_priority(s, cur);
		ds_priority_delete_min(s);
		var row = floor(cur/global.mapWidth);
		var col =  cur % global.mapWidth;		
		
		if (steps > maxDis) break;
	
		// add 4 neighbors
		for (var i=0; i<4; i++){
		
			// check if off map
			var nr = row + dx[i];
			var nc = col + dy[i];
			if (nr<0 || nc<0 || nr==global.mapHeight || nc==global.mapWidth) continue;
		
			// check if visited
			var np =  nr * global.mapWidth + nc;
			if (vis[np] == 1) continue;
			vis[np] = 1;
		
			// add to pqueue, checking special condition
			var ns = steps+energyTo[get_tile_type(global.grid[np])];
			if (ns <= maxDis && canFunc(np)){
				ds_priority_add(s, np, ns);
				res[count++] = global.grid[np];
			}
		}
	}

	ds_priority_destroy(s);
	return res;
}


// returns all tiles (including its own) within a certain
// distance of a tile. if with_soldiers is true, only tiles
// with soldiers will be returned
function get_tiles_from_euclidean(tile_pos, dist, canFunc) {
	
	if (canFunc == undefined)
		canFunc = possible_attack_tiles;
	
	var row = floor(tile_pos / global.mapWidth);
	var col = tile_pos % global.mapWidth;
	
	var res = [], len = 0;
	for (var xx = col-dist; xx <= col+dist; xx++) {
		for (var yy = row-dist; yy <= row+dist; yy++) {
			if ((xx == col && yy == row) || !point_in_rectangle(xx,yy,0,0,global.mapWidth-1,global.mapHeight-1))
				continue;
			else if ((xx-col)*(xx-col)+(yy-row)*(yy-row) <= dist*dist) {
				var np = global.mapWidth*yy + xx;
				if (canFunc == undefined || canFunc(np)) 
					res[len++] = global.grid[np];
			}
		}
	}
	
	
	return res;
}
