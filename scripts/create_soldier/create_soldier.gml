/// @description Creates a soldier with sprite sind at position pos
/// @param sind
/// @param pos


with (global.grid[argument1]){

	if (soldier == -1){
		soldier = instance_create_depth(x,y,0,obj_infantry);
		with(soldier){
			sprite_index = argument0;
			team = get_team(sprite_index);			
		}
		
		update_fog();
	}
}
