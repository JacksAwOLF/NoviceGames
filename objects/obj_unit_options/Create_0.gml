/// @description Insert description here
// You can write your code in this editor

event_inherited();

global.unit_options_active = false;
// array of structures {sprite, execute}
unit_options = [];
on_active_change = -1;
on_inactive_change = -1;

toggle_active = function() {
	switch(state) {
		case VisualState.active: 
		{
			state = VisualState.inactive;
			x = inactive_offset[0]
			y = inactive_offset[1]
			
			if (on_inactive_change != -1)
				on_inactive_change();
			global.unit_options_active = false;
			
			break;
		}
		
		case VisualState.inactive:
		{
			state = VisualState.active;
			x = origw
			y = origh
		
			if (on_active_change != -1)
				on_active_change();
				
			break;
		}
	}
}
