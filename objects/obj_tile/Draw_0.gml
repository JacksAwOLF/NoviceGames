/// @description Drawing sprites with size


var alpha_value = 1;
if (hide_soldier) alpha_value = 0.5;

// draw the terrain
draw_sprite_stretched_ext(sprite_index, 0, x, y, size, size, c_white, alpha_value);										// the tile on the bottom

// draw the road if needed
if (road){
	var ind = 0;
	// up, right, down, left
	//debug(pos, pos/global.mapWidth);
	if (floor(pos/global.mapWidth)>0 && global.grid[pos-global.mapWidth].road) ind += 1;
	if ((pos+1)%global.mapWidth>0 && global.grid[pos+1].road) ind += 2;
	if (floor(pos/global.mapWidth)<global.mapHeight-1 && global.grid[pos+global.mapWidth].road) ind += 4;
	if (pos%global.mapWidth>0 && global.grid[pos-1].road) ind += 8;
	
	draw_sprite_stretched_ext(spr_tile_road, ind, x, y, size, size, c_white, alpha_value);
}

// draw borders around it
if (mouseIn) draw_sprite_stretched_ext(spr_select_underMouse, 0, x, y, size, size, c_white, 1);					// mouse in gray box
if (possible_move) draw_sprite_stretched_ext(spr_select_possibleMove, 0, x, y, size, size, c_white, 1);			// a possible move, yellow box
if (possible_attack && !hide_soldier) draw_sprite_stretched_ext(spr_select_possibleAttack, 0, x, y, size, size, c_white, 1);		// a possible attack, red box
if (possible_path) draw_sprite_stretched_ext(spr_select_possiblePath, 0, x, y, size, size, c_white, 1);			// possible path

// draw soldiers if needed
var soldier_index = 0; if (global.selectedSoldier == id) soldier_index = 1;
if (soldier != -1 && !hide_soldier){	
	
	var spr_index = soldier.sprite_index;
	var scale_factor = size/sprite_get_width(spr_index);
	
	var xx = x, yy = y;
	
	// we need to reposition x, y based on rotation
	if (soldier.direction == 180 || soldier.direction == 270) xx += size;
	if (soldier.direction == 90 || soldier.direction == 180) yy += size;
		
	draw_sprite_ext(spr_index, soldier_index, xx, yy, scale_factor, scale_factor, soldier.direction, c_white, 1);				// the soldier on this tile
	draw_healthbar(x, y, x+size, y+(size)/8, (soldier.my_health/soldier.max_health)*100, c_black, c_red, c_green, 0, true,false);
}

if (draw_temp_soldier != -1)
	draw_sprite_stretched_ext(draw_temp_soldier, 0,  x, y, size, size, c_navy, 0.5);								// the iamge of potential soldier placed here
