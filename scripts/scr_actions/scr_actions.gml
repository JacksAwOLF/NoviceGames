// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function Action() constructor {
	
	// these are functions that will be called from obj_clickHandler
	// should return a boolean: true if this function should be processed again
	// false if not
	leftClick = -1;
	doubleClick = -1;
	step = -1;
	
	// when set to true, will process this action again
	// in the same step when the action ended
	// (clicking on another soldier to deselect 
	// current's movement and start new movement)
	processAgainIfEnd = false;
	
	// when set to true, will make sure that 
	// future actions cannot be picked up until
	// this one is dropped
	preventFutureActions = false;
}

enum Actions { 
	movement, attack
};
