// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function move_down(ownSoldiers, enemySoldiers) {
	debug("moving down");
	var moves = [], sze = 0;
	for (var i = 0; i < array_length(ownSoldiers); i++) {
		var row = getRow(ownSoldiers[i].tileInst.pos);
		var col = getCol(ownSoldiers[i].tileInst.pos);
		
		if (row+1 < global.mapHeight) {
			var nxt = global.grid[(row+1)*global.mapWidth + col];
			moves[sze++] = [ownSoldiers[i], nxt, [nxt]];
		}
	}
	
	return moves;
};


function follow_nearest(ownSoldiers, enemySoldiers) {
	var moves = [], size = 0;
	for (var i = 0; i < array_length(ownSoldiers); i++) {
		var closestEnemyDist = global.mapWidth + global.mapHeight + 1;
		
		for (var j = 0; j < array_length(enemySoldiers); j++) {
			var colDiff = getColDiff(ownSoldiers[i].tileInst.pos, enemySoldiers[j].tileInst.pos);
			var rowDiff = getRowDiff(ownSoldiers[i].tileInst.pos, enemySoldiers[j].tileInst.pos);
			
			if (colDiff + rowDiff < closestEnemyDistance) {
				closestEnemyDist = colDiff + rowDiff;
				/*
				var nextRow = 
				moves[size++] = */
			}
		}
	}
	
	return moves;
	
}
