/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

success = 0;			// which frame of sprite to play if success (0 default)
success_count = 0;		// how many frames left of animation
success_duration = 5;	// duration to show success animation


hide_key = ord("G");

// function to validate current followSoldier value; else will change to a valid value
// returns true if a valid value for followSoldier was found
refreshValue = function() {
	var visible_team = global.edit ? global.turn % 2 : global.playas;
	var sze = ds_list_size(global.allSoldiers[visible_team]);
	
	global.followSoldier = (global.followSoldier + sze) % sze;
	
	// find movable soldier on current team starting from last followed soldier
	var isMovableSoldier = false;
	for (var i = 0; i < sze && !isMovableSoldier; i++) {
		var index = (global.followSoldier + i) % sze;
		if (ds_list_find_value(global.allSoldiers[visible_team], index).can >= 1) {
			global.followSoldier = index;
			isMovableSoldier = true;
		}
	}
	
	return isMovableSoldier;
}


// function to process clicking
changeValue = function(change) {
	global.followSoldier += change;
	
	var camera_object = instance_find(obj_camera,0);
	if (refreshValue()) {
		success = (change < 0 ? 1 : 2);
		success_count = success_duration;
		
		camera_object.should_follow_turn = global.turn;
		
	} else {
		camera_object.should_follow_turn = -1;
	}
}

