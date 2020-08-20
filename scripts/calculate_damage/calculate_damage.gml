/// @description calculate the damage one soldier inflicts on another
/// @param attack_id
/// @param defend_id
var a = argument0, b = argument1;
return (a.my_health  / a.max_health)  *  a.max_damage;