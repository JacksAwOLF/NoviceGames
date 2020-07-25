/// @description Drawing sprites with size



draw_sprite_stretched_ext(sprite_index, 0, x, y, size, size, c_white, 1);										// the tile on the bottom
if (mouseIn) draw_sprite_stretched_ext(spr_select_underMouse, 0, x, y, size, size, c_white, 1);					// mouse in gray box
if (possible_move) draw_sprite_stretched_ext(spr_select_possibleMove, 0, x, y, size, size, c_white, 1);			// a possible move, yellow box
if (possible_attack) draw_sprite_stretched_ext(spr_select_possibleAttack, 0, x, y, size, size, c_white, 1);		// a possible attack, red box

var soldier_index = 0; if (global.selectedSoldier == id) soldier_index = 1;
if (soldier != -1){
	draw_sprite_stretched_ext(soldier.sprite_index, soldier_index, x, y, size, size, c_white, 1);				// the soldier on this tile
	draw_healthbar(x, y, x+size, y+(size)/8, (soldier.my_health/soldier.max_health)*100, c_black, c_red, c_green, 0, true,false);
}




if (draw_temp_soldier != -1){
	draw_sprite_stretched_ext(draw_temp_soldier, 0,  x, y, size, size, c_navy, 0.5);								// the iamge of potential soldier placed here
}
