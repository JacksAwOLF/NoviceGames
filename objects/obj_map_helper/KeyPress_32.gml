/// @description Insert description here
// You can write your code in this editor

erase_blocks();
global.selectedSoldier = -1;




if (global.action == "create" || global.action == "load"){
	
	global.changeSprite = -1;
	
	for (var i = 0; i < instance_number(obj_sprite_dropdown); i++)
		with(instance_find(obj_sprite_dropdown, i))
			dropdown_active = false;
}