/// @description Insert description here
// You can write your code in this editor

soldier_erase_attack();
soldier_erase_move();

global.selectedSoldier = -1;

for (var i=0; i<array_length_1d(global.changeSprite); i++)
	global.changeSprite[i] = -1;
	
for (var i = 0; i < instance_number(obj_sprite_dropdown); i++)
	with(instance_find(obj_sprite_dropdown, i))
		dropdown_active = false;