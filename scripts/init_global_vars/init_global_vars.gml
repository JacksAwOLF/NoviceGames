// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


function init_game_vars(){
	
	
	enum Soldiers {tanks, infantry, ifvs, destroyer, motorboat, carrier, bomber, recon};
	enum Classes {scout, melee, range, none};
	enum Tiles {road, open, rough, mountain, others};
	
	enum Units {
		INFANTRY_M, TANK_M, IFV_M,	// must be in infantry, tank, ifv order at the beginning
		INFANTRY_R, TANK_R, IFV_R, 
		INFANTRY_S, TANK_S, IFV_S, 
		END,
		DESTROYER,
		MOTORBOAT,
		CARRIER,
		BOMBER,
		RECON,
		FIGHTER
	};
	
	var unit_param = function(unit, max_health, max_damage, attk_range, 
							  movement, vision, energy, hut_limit, name) {
								  
		global.max_health[unit] = max_health;
		global.max_damage[unit] = max_damage;
		global.attack_range[unit] = attk_range;
		global.movement[unit] = movement;
		global.vision[unit] = vision;
		global.energy[unit] = energy;
		global.hutlimit[unit] = hut_limit;
		global.unitNames[unit] = name;
	};
	
	// land units
	unit_param(Units.TANK_M,		5,  2,  1.42, 6,  2.2, [2,3,3,99],     3,	 "Melee Tank");
	unit_param(Units.IFV_M,			5,  2,  1.42, 15, 2.2, [3,5,99,99],    3,	 "Melee IFV");
	unit_param(Units.INFANTRY_M,	5,  2,  1.42, 2,  2.2, [1,1,2,2],      3,	 "Melee Infantry");
	
	unit_param(Units.TANK_R,		1,  4,  3,    6,  1,   [2,3,3,99],     7,	 "Ranged Tank");
	unit_param(Units.IFV_R,			1,  4,  3,    15, 1,   [3,5,99,99],    7,	 "Ranged IFV");
	unit_param(Units.INFANTRY_R,	1,  4,  3,    2,  1,   [1,1,2,2],      7,	 "Ranged Infantry");
	
	unit_param(Units.TANK_S,		1,  1,  1,    6,  4,   [2,3,3,99],     5,	 "Scout Tank");
	unit_param(Units.IFV_S,			1,  1,  1,    14, 4,   [3,5,99,99],    5,	 "Scout IFV");
	unit_param(Units.INFANTRY_S,	1,  1,  1,    2,  4,   [1,1,2,2],      5,	 "Scout Infantry");
	
	// naval units
	unit_param(Units.DESTROYER,		10, 5,  15,   5,  8,   [1,1,1,1],      -1,	 "Destroyer");
	unit_param(Units.MOTORBOAT,		1,  15, 2,    8,  2,   [1,1,1,1],      5,	 "Motorboat");
	unit_param(Units.CARRIER,		15, -1, 999,  3,  5,   [1,1,1,1],      -1,	 "Seaplane Carrier");
	// seaplanes
	unit_param(Units.BOMBER,		1,  5,  999,  10, 0,   [1,1,1,1],      2,	 "Bomber Seaplane");
	unit_param(Units.RECON,			1,  -1, 999,  7,  15,  [1,1,1,1],      2,	 "Recon Seaplane");
	unit_param(Units.FIGHTER,		1,  1,  999,  15, 0,   [1,1,1,1],      -1,	 "Fighter Seaplane");
	
	global.unitSprites[Units.TANK_M] = [spr_tanks, spr_tanks1];
	global.unitSprites[Units.TANK_S] = [spr_tanks, spr_tanks1];
	global.unitSprites[Units.TANK_R] = [spr_tanks, spr_tanks1];
	
	global.unitSprites[Units.IFV_M] = [spr_ifvs, spr_ifvs1];
	global.unitSprites[Units.IFV_R] = [spr_ifvs, spr_ifvs1];
	global.unitSprites[Units.IFV_S] = [spr_ifvs, spr_ifvs1];
	
	global.unitSprites[Units.INFANTRY_M] = [spr_infantry, spr_infantry1];
	global.unitSprites[Units.INFANTRY_R] = [spr_infantry, spr_infantry1];
	global.unitSprites[Units.INFANTRY_S] = [spr_infantry, spr_infantry1];
	
	global.elevation[Tiles.open] = 1;
	global.elevation[Tiles.rough] = 1.1;
	global.elevation[Tiles.mountain] = 2;
	global.elevation[Tiles.others] = 0;
	
	global.tileNames[Tiles.road] = "Road";
	global.tileNames[Tiles.mountain] = "Mountain";
	global.tileNames[Tiles.open] = "Open";
	global.tileNames[Tiles.rough] = "Rough";
	global.tileNames[Tiles.others] = "Other?";
	
}