/// @description set mouseIn and chage sprite on click

mouseIn = x <= mouse_x && mouse_x <= x+size
	&& y <= mouse_y && mouse_y <= y+size;

draw_temp_soldier  = -1;


event_inherited();

if mouseIn {	
	

	
	
	// draw temp army sprite if there is a selected 
	if (global.selectedSoldier != -1) {
		if (possible_move)
			draw_temp_soldier = global.selectedSoldier.soldier.sprite_index;
		
		
		// always maintain the last two tiles we hovered over
		if (global.prevHoveredTiles[0] != id) {
			global.prevHoveredTiles[1] = global.prevHoveredTiles[0];
			global.prevHoveredTiles[0] = id;
		
			soldier_update_path(0);
		}
		//soldier_init_attack();
	}
	

}   // end of if (mouse_in)

