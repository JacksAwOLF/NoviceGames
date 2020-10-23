// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function getRow(pos){
	return floor(pos/global.mapWidth);
}

function getCol(pos){
	return pos%global.mapWidth;
}

function getPos(row, col){
	return row * global.mapWidth + col;
}

function getRowDiff(pos1, pos2){
	return (getRow(pos2) - getRow(pos1) + global.mapHeight) % global.mapHeight;
}

function getColDiff(pos1, pos2){
	return (getCol(pos2) - getCol(pos1) + global.mapWidth) % global.mapWidth;
}


function updatePos(pos, dRow, dCol){
	return getPos( 
		(getRow(pos) + dRow + global.mapHeight) % global.mapHeight,
		(getCol(pos) + dCol + global.mapWidth) % global.mapWidth
	);
}

function getWindowWidth(){
	return camera_get_view_width(view_get_camera(0));
}

function getWindowHeight(){
	return camera_get_view_height(view_get_camera(0));
}

function getCenteredPos(objSize, canvasSize, proportion){
	if (proportion == undefined) proportion = 1;
	return (canvasSize * proportion - objSize) / 2;
}

function centerObjectInWindow(object, xProportion, yProportion, xDeltaPro, yDeltaPro, ddepth, ssprite){
	if (xDeltaPro == undefined) xDeltaPro = 0;
	if (yDeltaPro == undefined) yDeltaPro = 0;
	if (ddepth == undefined) ddepth = -1;
	if (ssprite == undefined) ssprite = object_get_sprite(object);;
	
	var wH = getWindowHeight(), wW = getWindowWidth();
	return instance_create_depth(
		wW * xDeltaPro + getCenteredPos(sprite_get_width(ssprite), wW, xProportion),
		wH * yDeltaPro + getCenteredPos(sprite_get_height(ssprite), wH, yProportion),
		ddepth, object
	);
}
