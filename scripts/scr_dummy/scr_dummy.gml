

// called when user clicks on the button
// crerates possible deploy tiles for the dummy soldier
function dummy_create_init(){
	var gss = global.selectedSoldier;
	var arr = get_vision_tiles(gss);	// this is an array of tile instances
	for (var i=0; i<array_length(arr); i++)
		if (arr[i].soldier == -1)
			arr[i].possible_attack = true;
	global.unit_options_active = true;
	
	// called afteer user clicks a tile with deployable thing
	// creates the dummy at the spot
	global.processClick = function(tileClicked){
		var gss = global.selectedSoldier;
		with(create_soldier(Units.INFANTRY_S, gss.team, tileClicked.pos, gss, false, true, 0)){
			// this should prevent the scout from ever doing anything
			defaultCan = 0;
			vision = 0;
			move_range = 0;
			timeToLive = 2;
			discovered = false;
		}
		
		event_perform_object(obj_map_helper, ev_keypress, vk_space);
	}
}

// called before we switch to the next move so we can
// see if enemy spotted it
// subtract life force from this dum dum dummy
function dummy_next_move(){
	with(obj_infantry){
		if (team != global.turn%2 && timeToLive != -1){
			discovered = discovered || !(tilePos.hide_soldier);
			if (discovered) timeToLive -= 1;
			if (timeToLive == 0) destroy_soldier(id, true);
		}
	}
}


// called in infantry create evenet
function dummy_soldier_create(){
	timeToLive = -1;
	discovered = false;
}
