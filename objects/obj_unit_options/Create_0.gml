/// @description Insert description here
// You can write your code in this editor

event_inherited();

// array of structures {sprite, execute}
unit_options = [];

toggle_active = function() {
	switch(state) {
		case VisualState.active: 
		{
			state = VisualState.inactive;
			x = inactive_offset[0]
			y = inactive_offset[1]
			
			break;
		}
		
		case VisualState.inactive:
		{
			state = VisualState.active;
			x = origw
			y = origh
			
			break;
		}
	}
}
