
// function to validate current followSoldier value; else will change to a valid value
// returns true if a valid value for followSoldier was found
function refreshFocus(){
	var visible_team = global.edit ? global.turn % 2 : global.playas;
	var sze = ds_list_size(global.allSoldiers[visible_team]);
	
	// find movable soldier on current team starting from last followed soldier
	var isMovableSoldier = false;
	for (var i = 0; i < sze && !isMovableSoldier; i++) {
		var index = (global.followSoldier + sze + i) % sze;
		if (ds_list_find_value(global.allSoldiers[visible_team], index).can >= 1) {
			global.followSoldier = index;
			isMovableSoldier = true;
		}
	}
	
	return isMovableSoldier;
}
