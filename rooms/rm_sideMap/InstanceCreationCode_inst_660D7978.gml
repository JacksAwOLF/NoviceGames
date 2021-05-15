interact = function()
{
	with (obj_player) {
		x = other.x;
		
		path_start(path_staircase_up, 2, path_action_stop, false);
	}
}