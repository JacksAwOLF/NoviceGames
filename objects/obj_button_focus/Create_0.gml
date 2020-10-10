/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

success = 0;			// which frame of sprite to play if success (0 default)
success_count = 0;		// how many frames left of animation
success_duration = 5;	// duration to show success animation


hide_key = ord("G");


// function to process clicking
changeValue = function(change) {
	global.followSoldier += change;
	
	if (refreshFocus()) {
		success = (change < 0 ? 1 : 2);
		success_count = success_duration;
		
		global.shouldFocusTurn = global.turn;
		
	} else {
		global.shouldFocusTurn = -1;
	}
}

