interact = function()
{
	with (obj_player) {
		x = other.x;
		path_start(path_staircase_down, 2, path_action_stop, false);
	}
}