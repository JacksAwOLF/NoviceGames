/// @description Insert description here
// You can write your code in this editor

toTransition = -1;
interact = function() {
	if (toTransition != -1)
		room_goto(toTransition);
}