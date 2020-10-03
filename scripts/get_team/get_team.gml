/// @description gets which team it is from the sprite index
/// @param sprite_index 
function get_team(argument0) {
	if (argument0 == -1) return -1;
	
	var name = sprite_get_name(argument0);
	if (string_char_at(name, string_length(name)) == "1")
		return 1
		
	return 0;
}

function is_my_team(object) {
	return (object.team == (global.edit ? global.turn % 2 : global.playas));
}

function is_my_team_sprite(object_sprite) {
	var team = get_team(object_sprite);
	return (team == (global.edit ? global.turn % 2 : global.playas));
}

/// @description in play mode, returns whether or not it si your turn
function my_turn(){
	return 	global.action=="playw"&&global.turn%2==0 || 
		global.action=="playb"&&global.turn%2==1; 
}
