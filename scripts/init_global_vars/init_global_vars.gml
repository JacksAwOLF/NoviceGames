// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function init_game_vars(){
	
	global.max_health[Classes.scout, Soldiers.infantry] = 1;
	global.max_health[Classes.scout, Soldiers.tanks] = 1;
	global.max_health[Classes.scout, Soldiers.ifvs] = 1;
	global.max_health[Classes.melee, Soldiers.infantry] = 5;
	global.max_health[Classes.melee, Soldiers.tanks] = 5;
	global.max_health[Classes.melee, Soldiers.ifvs] = 5;
	global.max_health[Classes.range, Soldiers.infantry] = 1;
	global.max_health[Classes.range, Soldiers.tanks] = 1;
	global.max_health[Classes.range, Soldiers.ifvs] = 1;
	
	global.max_damage[Classes.scout, Soldiers.infantry] = 1;
	global.max_damage[Classes.scout, Soldiers.tanks] = 1;
	global.max_damage[Classes.scout, Soldiers.ifvs] = 1;
	global.max_damage[Classes.melee, Soldiers.infantry] = 2;
	global.max_damage[Classes.melee, Soldiers.tanks] = 2;
	global.max_damage[Classes.melee, Soldiers.ifvs] = 2;
	global.max_damage[Classes.range, Soldiers.infantry] = 4;
	global.max_damage[Classes.range, Soldiers.tanks] = 4;
	global.max_damage[Classes.range, Soldiers.ifvs] = 4;
	
	global.attack_range[Classes.scout, Soldiers.infantry] = 1;
	global.attack_range[Classes.scout, Soldiers.tanks] = 1;
	global.attack_range[Classes.scout, Soldiers.ifvs] = 1;
	global.attack_range[Classes.melee, Soldiers.infantry] = 1;
	global.attack_range[Classes.melee, Soldiers.tanks] = 1;
	global.attack_range[Classes.melee, Soldiers.ifvs] = 1;
	global.attack_range[Classes.range, Soldiers.infantry] = 3;
	global.attack_range[Classes.range, Soldiers.tanks] = 3;
	global.attack_range[Classes.range, Soldiers.ifvs] = 3;
	
	
	global.movement[Soldiers.tanks] = 6;
	global.movement[Soldiers.infantry] = 2;
	global.movement[Soldiers.ifvs] = 15;
	
	global.elevation[Tiles.open] = 1;
	global.elevation[Tiles.rough] = 1.1;
	global.elevation[Tiles.mountain] = 2;
	global.elevation[Tiles.others] = 0;

	global.energy[Soldiers.tanks] = [2,3,3,99];
	global.energy[Soldiers.infantry] = [1,1,2,2];
	global.energy[Soldiers.ifvs] = [3,5,99,99];

	global.vision[Classes.scout] = 4;
	global.vision[Classes.melee] = 2.2;
	global.vision[Classes.range] = 1;


	global.hutlimit[Classes.scout] = 5;
	global.hutlimit[Classes.melee] = 3;
	global.hutlimit[Classes.range] = 7;
	
	
	global.classNames[Classes.scout] = "Scout";
	global.classNames[Classes.melee] = "Melee";
	global.classNames[Classes.range] = "Ranged";
	
	global.unitNames[Soldiers.tanks] = "Tanks";
	global.unitNames[Soldiers.infantry] = "Infantry";
	global.unitNames[Soldiers.ifvs] = "IFVs";
	
	global.tileNames[Tiles.mountain] = "Mountain";
	global.tileNames[Tiles.open] = "Open";
	global.tileNames[Tiles.rough] = "Rough";
	global.tileNames[Tiles.others] = "Other?";
	
}