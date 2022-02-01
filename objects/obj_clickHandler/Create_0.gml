/// @description Insert description here
// You can write your code in this editor

event_inherited();

actionProcessOrder = [Actions.attack, Actions.movement];

// allow multiple actions to be in use at the same time
numProcessing = 0;
actionInUse = [];
for (var i=0; i<array_length(actionProcessOrder); i++)
	actionInUse[i] = false;

preventFutureActions = false;



debug("clickhandler created at", x, y);




processActions = function(actionFunctionName){
	
	//debug("processing", actionFunctionName);
	
	// so far all actions that I can think of only require
	// the tile that the mouse left clicked on
	// so the input doesn't have to be very general yet
	var tileId = collision_point(mouse_x, mouse_y, obj_tile, false, false);
	if (tileId == noone) exit;

	// allows multiple actions to be picked up
	// in a single step (moving and attacking)
	for (var i=0; i<array_length(actionProcessOrder); i++){
		if (actionInUse[i] || numProcessing == 0 || !preventFutureActions)	{
			
			// check if the corresponding function exists in this action
			var action = global.allActions[actionProcessOrder[i]];
			var processFunc = variable_struct_get(
				action, actionFunctionName);
			if (processFunc == undefined || processFunc == -1) 
				continue;
			
			// update numActions and actionInUse
			var newUse = processFunc(tileId); // call this action
			var diff = actionInUse[i] != newUse;
			if (diff){
				numProcessing += (newUse ? 1 : -1);	
				// debug(newUse ? "picked up" : "threw out");
				
				if (action.preventFutureActions){
					preventFutureActions = newUse && action.preventFutureActions;
				}
			}
			
			actionInUse[i] = newUse;
			
			// process the same action again if the action specifies so
			if (diff && !newUse && action.processAgainIfEnd)
				i--;
			
			// edge case
			if (actionFunctionName == "leftClick"){
				enableDoubleClick = newUse;
			}
		}
	}
}