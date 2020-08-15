// return array of obj_tile_parent that are (arg1) away from (arg0) 


// arg2:
// -1 => excluding tiles that have a soldier in it
// 0 => all tiles in bounds
// 1 => only tiles that have a soldier

// arg3:
// true: take into account of mountians/tivers
// false: nah

// arg4:
// the energy array

// data that  goes on the stack stores 3 variables in 1 integer
// data%(argument[1]+1) = #energy left
// data/(argument[1]+1) = ypos*global.mapWidth + xpos

// however we only return an array of integers that only
// represent the position



// energy exhuasted to
// 0: move to road
// 1: open
// 2: rough
// 3: mountain
var possible_terrain = array(spr_tile_road, spr_tile_flat, spr_tile_ocean, spr_tile_mountain, spr_tile_border);
var energy = array(1,1,2,3);
if (argument_count == 5) energy = argument[4]
energy[4] = 99;

/*energy[0,0] = 1; energy[0,1] = 2; energy[0,2] = 2; energy[0, 3] = 99999;
energy[1,0] = 2; energy[1,1] = 1; energy[1,2] = 3; energy[1, 3] = 99999;
energy[2,0] = 2; energy[2,1] = 3; energy[2,2] = 1; energy[2, 3] = 99999;
energy[3,0] = 99999; energy[3,1] = 99999; energy[3,2] = 99999; energy[3, 3] = 99999;*/



var start = argument[0];
var z = argument[1];

var res; var count = 0;
res[count++] = global.grid[start];
if (z == 0) return res;

var vis = array_create(global.mapWidth * global.mapHeight);	// each entry is initialized to 0
vis[start] = 1;

// helps with  neighbor kids
var dx = array(0,0,-1,1);		 
var dy = array(-1,1,0,0);	

var s = ds_priority_create();			
ds_priority_add(s, start, 0);

while(!ds_priority_empty(s)){

	// pop off and get data
	var cur = ds_priority_find_min(s);
	var steps = ds_priority_find_priority(s, cur);
	ds_priority_delete_min(s);
	var row = floor(cur/global.mapWidth);
	var col =  cur % global.mapWidth;
	
	// add the neighbors
	for (var i=0; i<4; i++){
		
		// check if off map
		var nr = row + dx[i];
		var nc = col + dy[i];
		if (nr<0 || nc<0 || nr==global.mapHeight || nc==global.mapWidth) continue;
		
		// check if visited
		var np =  nr * global.mapWidth + nc;
		if (vis[np] == 1) continue;
		vis[np] = 1;
		
		
		
		// if htere's  a  soldier blocking  here, can't  go
		if (argument[2] == -1 && global.grid[np].soldier != -1) continue;
		
		
		
		// add to queue only if it can possibly add more kids
		var dis = 1;
		if (argument[3]){
			var tt = global.grid[np].sprite_index, to;
			if (global.grid[np].road) tt = spr_tile_road;
			to = posInArray(possible_terrain, tt);
			dis = energy[to];
		}
		
		var ns =  steps + dis;
		if (ns < z) ds_priority_add(s, np, ns);
		

		if (argument[2] == 1 && global.grid[np].soldier == -1) continue;
		if (!argument[3] || ns<z+1) res[count++] = global.grid[np];
	}
}

ds_priority_destroy(s);

return res;