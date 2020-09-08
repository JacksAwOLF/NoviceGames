function next_move() {
	
	debug("called next move");

	// reset all soldiers moving thing
	var n = instance_number(obj_infantry);
	for (var i=0; i<n; i++)
		with(instance_find(obj_infantry, i))
			can = true;
	
	// increment the hut spawn times
	n = instance_number(obj_hut);
	for (var i=0; i<n; i++)
		with(instance_find(obj_hut, i))
			if (steps!=-1 && get_team(soldier_sprite) == global.turn%2){
				steps = min(steps+1, limit);
				//debug("changed step to", steps,  "at", pos);
			}
	
	
	if (!global.edit && network_my_turn())
		send_buffer(BufferDataType.yourMove, []);
			
			
	global.turn++; // relative positioning is important


	// deselect soldiers and clear  drawings
	erase_blocks(true);


	if  (global.edit){
		global.changeSprite = -1;
		global.selectedSoldier = -1;
		update_fog();
	} 
	
	
	update_won();
}
