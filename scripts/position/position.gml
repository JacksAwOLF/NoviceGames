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
