/// @description calculate the damage one soldier inflicts on another
/// @param attack_id
/// @param defend_id
function calculate_damage(argument0, argument1) {
	var a = argument0, b = argument1;
	
	// tanks can't get one-shotted
	if (get_soldier_type(b) == Soldiers.tanks && b.my_health == b.max_health) 
		return min(a.max_damage, b.max_health-0.1);
		
	return a.max_damage;
}
