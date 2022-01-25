// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function ClickObjInput() constructor {
		
}

function ClickObj(_processClick) constructor {
	
	clickInd = 0;
	processClick = _processClick;
	
	click = function(tile){
		if (!processClick()){
			clickInd = 0;
			return false;
		}
		return true;
	}
	
	allowOtherClicks = true;
	processOtherClicksIfEnd = true;
}

enum ClickActions { 
	movement
};

function movementProcessClick(input) {
	switch(input.clickInd){
	case 0: 
		sold = input.tile.soldier;
		if (sold != -1 && is_my_team_obj(sold)){
			return true;	
		}
		return false;
	default:
		if (input.tile.possibleMove != -1){
			return true;
		}
		return false;
		break;
	}
}

global.allActions[ClickActions.movement] = 
	new ClickObj(movementProcessClick);


