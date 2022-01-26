// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function Action() constructor {
	
	// these are functions that will be called from obj_clickHandler
	// should return a boolean: true if this action is multi-step and should be picked up
	// false if not
	leftClick = -1;
	doubleClick = -1;
	
	// when set to true, will process this action again
	// in the same step when the action ended
	// (clicking on another soldier to deselect 
	// current's movement and start new movement)
	processAgainIfEnd = false;
}

enum Actions { 
	movement, attack
};
