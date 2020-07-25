/// @description Insert description here
// You can write your code in this editor


var turn_string = "Turn: " + (global.turn % 2 == 0 ? "Grey" : "Black");
draw_text(x,y,turn_string);