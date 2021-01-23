// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function update_change_sprite(tile_instance, selected_sprite) {
	erase_blocks(true);
	global.selectedSoldier = -1;
	
	global.changeSprite = selected_sprite;

	// if this button is a soldier button, update other svars
	if (tile_instance.description == "units")
		refresh_change_vars(tile_instance, global.changeSprite);
}

function refresh_change_vars(tile_instance, selected_choice) {
	
	var index = posInArray(tile_instance.binded_dropdown.options, selected_choice);
	var unit_id = 3 * global.soldier_vars[Svars.unit_page] + index;
	
	global.soldier_vars[Svars.attack_range] = global.attack_range[unit_id]; 
	global.soldier_vars[Svars.max_health] = global.max_health[unit_id]; 
	global.soldier_vars[Svars.max_damage] = global.max_damage[unit_id];
		
	//global.soldier_vars[Svars.vision] = global.vision[unit_id];
}