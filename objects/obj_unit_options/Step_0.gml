/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

var next_state = VisualState.inactive;
if (global.selectedSoldier != -1 &&
		global.selectedSoldier.can &&
		array_length(unit_options) > 0)
	next_state = VisualState.active;
	
if (next_state != state)
	toggle_active();
