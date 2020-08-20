if (global.selectedSoldier != -1){


// default energy values in global.energy[soldier.type]
// default move range is in global.movement[solder.type]
// change in load_map...

var type;

with(global.selectedSoldier.soldier){
	type = get_soldier_type(id);
	
	if (can){
		poss_moves = get_tiles_from(global.selectedSoldier.pos, global.movement[type], -1, true, global.energy[type]);
		for (var i=0; i<array_length_1d(poss_moves); i++)
			poss_moves[i].possible_move = true;
	}
}

init_dijkstra(global.selectedSoldier.pos, 0, global.movement[type], -1, 0, 0);


}