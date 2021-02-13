/// @description calculate the damage one soldier inflicts on another
/// @param attack_id
/// @param defend_id
function calculate_damage(attackerInst, attackedInst, damageOverride) {
	var a = attackerInst, b = attackedInst;
	
	var damage = -1;
	
	// some special cases for attacking infantry
	if (b.object_index == obj_infantry) {
		
		// tanks ignore the first attack
		if (is_tank(b) && b.my_health == b.max_health)	
			damage = 0.1;
			
		// defense bonus for formations
		else if (b.formation != -1) {	
			var defenseBonus = max(0.5, 1 - 0.025*global.formation[b.formation].contact_count);
			damage = defenseBonus * a.max_damage;
		}
		
	}
	
	if (damage == -1){
		damage = a.max_damage;
		if (damageOverride != -1) damage = damageOverride;
	}
	
	
	// attacking from the side overrides simple damage calculation
	if (b.object_index == obj_infantry) {
		var ohko = false, posdiff = a.tilePos.pos - b.tilePos.pos;
		if (posdiff == 1 || posdiff == -1)
			ohko = (attackedInst.direction % 180 == 0);
		if (posdiff == global.mapWidth || posdiff == -global.mapWidth)
			ohko = (attackedInst.direction == 90 || attackedInst.direction == 270);

		if (ohko && (!is_tank(attackedInst) || attackedInst.my_health != attackedInst.max_health))
			damage = attackedInst.my_health;
	}
	
	
	// special unit healing ability overrides attacking from the side
	if (a.team == b.team && a.unit_id == Units.TANK_S && a.special){
		with (b) return -(max_health - my_health);
	}
	
	
	return damage;
}
