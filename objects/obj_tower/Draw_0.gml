/// @description Insert description here
// You can write your code in this editor

draw_self();


var p = global.grid[pos];
draw_healthbar(x, y+p.size/4, x+p.size, y+p.size, 
health, c_white, c_gray, c_white,0, 1, 1);

