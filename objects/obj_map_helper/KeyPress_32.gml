/// @description Clear all selections

if (global.map_loaded) {
	erase_blocks(true);
	global.selectedSoldier = -1;


	if (global.edit){
	
		global.changeSprite = -1;
	
		for (var i = 0; i < instance_number(obj_sprite_dropdown); i++)
			with(instance_find(obj_sprite_dropdown, i))
				dropdown_active = false;
				
		
		selected_dropdown = -1;
	}
}