/// @description Insert description here
// You can write your code in this editor

event_inherited();




// these variables are initialized when this is
// created in the obj_tile step event

// pos = 0;
// soldier_sprite = 0;
//  limit = 5;

// when cur reaches limit, 
// you can click on the hut and generate a soldier
steps = 0;
depth = 0;

if (global.edit){
	def_attack_range = global.soldier_vars[Svars.attack_range];
	def_max_health = global.soldier_vars[Svars.max_health];
	def_max_damage = global.soldier_vars[Svars.max_damage];
	def_class = global.soldier_vars[Svars.class];
	def_vision = global.soldier_vars[Svars.vision];
}