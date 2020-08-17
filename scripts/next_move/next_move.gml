for (var i=0; i<array_length_1d(global.changeSprite); i++)
	global.changeSprite[i] = -1;


var n = instance_number(obj_moveAndAttack);
for (var i=0; i<n; i++){
	with(instance_find(obj_moveAndAttack, i)){
		can_move = true;
		can_attack = true;
	}
}

n = instance_number(obj_hut);
for (var i=0; i<n; i++)
	with(instance_find(obj_hut, i))
		if (get_team(soldier_sprite) == global.turn%2)
			cur = min(cur+1, limit);
			
			
		
global.turn++; // relative positioning is important



soldier_erase_attack();
soldier_erase_move();
global.selectedSoldier = -1;


update_fog();






