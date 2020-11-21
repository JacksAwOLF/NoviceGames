/// @description calculate the damage one soldier inflicts on another
/// @param attack_id
/// @param defend_id
function calculate_damage(argument0, argument1) {
	var a = argument0, b = argument1;
	
	// tanks ignore the first attack
	if (is_tank(b) && b.my_health == b.max_health)
		return 0.1;
			
	return a.max_damage;
}
