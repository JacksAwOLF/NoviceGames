/// @description calculate the damage one soldier inflicts on another
/// @param attack_id
/// @param defend_id
function calculate_damage(argument0, argument1) {
	var a = argument0, b = argument1;
	
	
	if (b.object_index == obj_infantry) {
		
		if (is_tank(b) && b.my_health == b.max_health)	// tanks ignore the first attack
			return 0.1;
		else if (b.formation != -1) {	// defense bonus for formations
			
			var defenseBonus = max(0.5, 1 - 0.025*global.formation[b.formation].contact_count);
			return defenseBonus * a.max_damage;
		}
	}
	return a.max_damage;
}
