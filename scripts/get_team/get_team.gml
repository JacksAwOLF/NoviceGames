/// @description gets which team it is from the sprite index
/// @param sprite_index 
function get_team(argument0) {
	if (argument0 == -1) return -1;
	
	var name = sprite_get_name(argument0);
	if (string_char_at(name, string_length(name)) == "1")
		return 1
		
	return 0;
}

function is_my_team(teamNum) {
	if (global.edit)
		return teamNum == global.turn % 2;
	if (global.ai_team != -1)
		return teamNum != global.ai_team;
	return teamNum == global.playas;
}

function is_my_team_obj(obj) {
	return is_my_team(obj.team);
}

function is_my_team_spr(spr) {
	return is_my_team(get_team(spr));
}

/// @description in play mode, returns whether or not it si your turn
function my_turn(){
	return global.action=="playw"&&global.turn%2==0 || 
		global.action=="playb"&&global.turn%2==1; 
}
