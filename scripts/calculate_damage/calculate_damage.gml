/// @description calculate the damage one soldier inflicts on another
/// @param attack_id
/// @param defend_id
function calculate_damage(argument0, argument1) {
	var a = argument0, b = argument1;
	return a.max_damage;
	//return (a.my_health  / a.max_health)  *  a.max_damage;
}
