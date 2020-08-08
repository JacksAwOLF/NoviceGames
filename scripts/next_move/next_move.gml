for (var i=0; i<array_length_1d(global.changeSprite); i++)
	global.changeSprite[i] = -1;


var n = instance_number(obj_moveAndAttack);
for (var i=0; i<n; i++){
	with(instance_find(obj_moveAndAttack, i)){
		can_move = true;
		can_attack = true;
	}
}

global.turn++;



soldier_erase_attack();
soldier_erase_move();
global.selectedSoldier = -1;


update_fog();