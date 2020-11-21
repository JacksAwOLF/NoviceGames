/// @description Insert description here
// You can write your code in this editor

var add = 0;
if (mouse_y < y + sprite_height/3) add = 1;
else if (mouse_y > y + sprite_height/3*2) add = -1;

if (text == "Select"){
	var size = floor(Units.END / 3);
	global.soldier_vars[ind] = (global.soldier_vars[ind]+size+add)%size;
	
	// change availabe options for soldier select tiles
	for (var i = 0; i < 2; i++) {
		with (global.soldierSelectTile[i]) {
			for (var j = 0; j < 3; j++) 
				options[j] = global.unitSprites[j];

			// refresh top display
			options_id = 0;
			event_user(15);
		}
	}
	
	// changing class means loading default values
	refresh_change_vars(global.soldierSelectTile[0], global.soldierSelectTile[0].options[0]);
	
	
} else if (text == "Win") {
	var len = array_length(global.objectiveOptions);
	global.soldier_vars[ind] = (global.soldier_vars[ind]+len+add)%len;
	global.winFunction = global.soldier_vars[ind];
	
	update_won()
}
else global.soldier_vars[ind] = max(global.soldier_vars[ind]+add, 0);