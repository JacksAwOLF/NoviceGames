// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function update_change_sprite(sprite_index) {
	global.changeSprite = sprite_index;

	// if this button is a soldier button, update editSoldierType
	var checkSoldier = get_soldier_type_from_sprite(sprite_index);
	if (checkSoldier != -1)
		global.editSoldierType = checkSoldier;
		
	refresh_change_vars();
}

function refresh_change_vars(){
		
	var class = global.soldier_vars[Svars.class];
	
	global.soldier_vars[Svars.attack_range] = global.attack_range[class,global.editSoldierType]; 
	global.soldier_vars[Svars.max_health] = global.max_health[class,global.editSoldierType]; 
	global.soldier_vars[Svars.max_damage] = global.max_damage[class,global.editSoldierType];
		
	global.soldier_vars[Svars.vision] = global.vision[class];
}