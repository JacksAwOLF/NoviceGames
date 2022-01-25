/// @description Insert description here
// You can write your code in this editor

event_inherited();

allActions = global.allActions;
actionProcessOrder = [ClickActions.movement];

// allow multiple actions to be in use at the same time
actionInUse = [];
for (var i=0; i<array_length(actionProcessOrder); i++){
	actionInUse[i] = false;
}

debug("clickhandler created at", x, y);