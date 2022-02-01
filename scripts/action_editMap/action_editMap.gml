// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
global.allActions[Actions.editMap] = new Action();
global.allActions[Actions.editMap].leftClick = function(tileId){
	with(tileId)
		tile_changeSprite();	
}