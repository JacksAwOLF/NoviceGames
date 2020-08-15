// return array of obj_tile_parent that are (arg1) away from (arg0) 
// return array of tiles of shortest path from (arg0) to (arg1) within (arg2) energy

// arg3:
// -1 => excluding tiles that have a soldier in it
// 0 => all tiles in bounds
// 1 => only tiles that have a soldier

// arg4:
// true: take into account of mountians/tivers
// false: nah

// arg5:
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


var start = argument[0];
var nrg = argument[2];


global.from = array_create(global.mapWidth * global.mapHeight, -1);
global.dist = array_create(global.mapWidth * global.mapHeight, -1);

global.from[start] = start;
global.dist[start] = 0;

// helps with  neighbor kids
var dx = array(0,0,-1,1);		 
var dy = array(-1,1,0,0);	

var pq = ds_priority_create();			
ds_priority_add(pq, start, 0);

var soldier_id = get_soldier_type(global.selectedSoldier.soldier);


while(!ds_priority_empty(pq)){

	// pop off and get data
	var cur = ds_priority_find_min(pq);
	var steps = ds_priority_find_priority(pq, cur);
	
	ds_priority_delete_min(pq);
	
	var row = floor(cur/global.mapWidth);
	var col = cur % global.mapWidth;
	
	// add the neighbors
	for (var i=0; i<4; i++){
		
		// check if off map
		var nr = row + dx[i];
		var nc = col + dy[i];
		if (nr<0 || nc<0 || nr==global.mapHeight || nc==global.mapWidth) continue;
		
		// check if visited
		var np =  nr * global.mapWidth + nc;
		if (global.from[np] != -1) continue;
		if (argument[3] == -1 && global.grid[np].soldier != -1) continue; // if soldier blocking
		
		var ns = steps + (argument[4] ? 1 : get_energy_to_cross(soldier_id, global.grid[np]));
		if (ns <= nrg) {
		
			ds_priority_add(pq, np, ns);
		
			global.from[np] = cur;
			global.dist[np] = ns;
		}
	
		//if (argument[3] == 1 && global.grid[np].soldier == -1) continue;
	}
}

ds_priority_destroy(pq);

