/// @description Insert description here
// You can write your code in this editor


if (global.selectedSoldier.team != team
&& global.grid[pos].possible_attack){
	health -= calculate_damage(global.selectedSoldier.soldier, id);
	if (health <= 0) instance_destroy();
}