/// @description Insert description here
// You can write your code in this editor

var add = 0;
if (mouse_y < y + sprite_height/3) add = 1;
else if (mouse_y > y + sprite_height/3*2) add = -1;

if (text == "Weather") {
	global.soldier_vars[ind] = (global.soldier_vars[ind]+add+Weather.SIZE) % Weather.SIZE;
	global.weather = global.soldier_vars[ind];
	
} else if (text == "Select"){
	var size = ceil(Units.END / 3);
	global.soldier_vars[ind] = (global.soldier_vars[ind]+size+add)%size;
	
	// change availabe options for soldier select tiles
	for (var i = 0; i < 2; i++) {
		with (global.soldierSelectTile[i].binded_dropdown) {
			options = [];
			
			for (var j = 0; j < 3; j++) {
				var index = j+3*global.soldier_vars[other.ind];
				if (index < Units.END) 
					options[j] = global.unitSprites[index][i];
			}
			
			// refresh top display
			options_id = 0;
			global.soldierSelectTile[i].sprite_index = options[0];
		}
	}
	
	// changing class means loading default values
	//refresh_change_vars(global.soldierSelectTile[0], global.soldierSelectTile[0].binded_dropdown.options[0]);
	
	
} else if (text == "Win") {
	var len = array_length(global.objectiveOptions);
	global.soldier_vars[ind] = (global.soldier_vars[ind]+len+add)%len;
	global.winFunction = global.soldier_vars[ind];
	
	update_won()
	
} else if (ind == Svars.special){
	global.soldier_vars[ind] = max((global.soldier_vars[ind]+add+2)%2, 0);
}
else global.soldier_vars[ind] = max(global.soldier_vars[ind]+add, 0);
