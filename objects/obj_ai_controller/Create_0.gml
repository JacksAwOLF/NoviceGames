/// @description Insert description here
// You can write your code in this editor

calculateMoves = move_down;

reprocessMoves = function(pastMovesToDo) {
	var existsMove = false;
	for (var i = 0; i < array_length(pastMovesToDo); i++) {
		var path = pastMovesToDo[i][2];
		if (possible_move_tiles(path[array_length(path)-1].pos)) {
			existsMove = true;
			
			var swapper = pastMovesToDo[0];
			pastMovesToDo[0] = pastMovesToDo[i];
			pastMovesToDo[i] = swapper;
			
			break;
		}
	}
	
	return (existsMove ? pastMovesToDo : []);
};

movesToDo = -1; // array of [soldier instance, target tile instance, pathpoints (?)]
previousMoveTurn = -1;
previousMoveTime = -1;