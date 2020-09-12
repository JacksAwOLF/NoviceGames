/// @description gets which team it is from the sprite index
/// @param sprite_index 
function get_team(argument0) {
	if (argument0 == -1) return -1;
	
	var name = sprite_get_name(argument0);
	if (string_char_at(name, string_length(name)) == "1")
		return 1
		
	return 0;
}

function is_my_team(soldier) {
	return (soldier.team == (global.edit ? global.turn % 2 : global.playas));
}

function is_my_team_sprite(soldier_sprite) {
	var team = get_team(soldier_sprite);
	return (team == (global.edit ? global.turn % 2 : global.playas));
}
