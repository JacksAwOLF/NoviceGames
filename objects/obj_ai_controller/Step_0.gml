/// @description Insert description here
// You can write your code in this editor



if (!global.map_loaded || global.turn % 2 != global.ai_team) 
	exit;
else if (previousMoveTurn != global.turn) {
	movesToDo = calculateMoves(
		get_soldiers_from_team(global.ai_team), 
		get_soldiers_from_team(global.ai_team ^ 1)
	);
	
	previousMoveTurn = global.turn;
	
} else if (current_time - previousMoveTime > 1000) {
	previousMoveTime = current_time;
	
	if (array_length(movesToDo) == 0) {
		next_move();
		exit;
	}
	
	movesToDo = reprocessMoves(movesToDo);
	var currentMove = movesToDo[0];
	
	if (possible_move_tiles(currentMove[1].pos))
		soldier_attempt_move(currentMove[0].tileInst, currentMove[2]);
	else
		soldier_attack_tile(currentMove[0], currentMove[1]);
		
		
	array_delete(movesToDo, 0, 1);
}