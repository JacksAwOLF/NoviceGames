/// @description gets which team it is from the sprite index
/// @param sprite_index 
function get_team(argument0) {
	if (argument0 == -1) return -1;
	
	var name = sprite_get_name(argument0);
	if (string_char_at(name, string_length(name)) == "1")
		return 1
		
	return 0;
}
