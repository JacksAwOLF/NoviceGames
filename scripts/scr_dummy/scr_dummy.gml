
global.dummy_wait_time = 10;

// called in init_map
function dummy_init_map(){
	global.dummy_last_turn = [
		-global.dummy_wait_time,
		-global.dummy_wait_time
	];	
}


// called in infantry create evenet
function dummy_soldier_create(){
	timeToLive = -1;
	discovered = false;
}


// called when user clicks on the button
// crerates possible deploy tiles for the dummy soldier
function dummy_create_init(){
	var gss = global.selectedSoldier;
	
	if (gss.can != gss.defaultCan) return;
	if (global.turn - global.dummy_last_turn[gss.team] < global.dummy_wait_time) return;
	global.dummy_last_turn[gss.team] = global.turn;
	
	
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
	
	if (!global.edit && global.turn%2 == global.playas) return;
	
	// counnt the number of dummies
	var dummies = []
	with(obj_infantry)
		if (team != global.turn%2 && timeToLive != -1)
			append(dummies, id);
	if (array_length(dummies) == 0) return;
	
	
	// construct seen array of opposing team
	var seen = array_create(global.mapHeight * global.mapWidth, false);
	with(obj_infantry){ 
		if (team == global.turn%2){
			var arr = get_vision_tiles(id);
			for (var i=0; i<array_length(arr); i++)
				seen[arr[i].pos] = true;
		}
	}
		
	// check if dummies are around
	for (var i=0; i<array_length(dummies); i++) with(dummies[i]){
		discovered = discovered || seen[tilePos.pos];
		if (discovered) timeToLive -= 1;
		if (timeToLive == 0) 
			destroy_soldier(id, true);
	}
}
