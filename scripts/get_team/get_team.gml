/// @description gets which team it is from the sprite index
/// @param sprite_index 
function get_team(argument0) {

	var name = sprite_get_name(argument0);
	if (string_char_at(name, string_length(name)) == "1")
		return 1
	else return 0;


}
