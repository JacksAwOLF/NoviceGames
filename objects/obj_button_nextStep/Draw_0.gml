/// @description Insert description here
// You can write your code in this editor


if (state == VisualState.inactive) exit;

draw_self();


var turn_string = "Turn: " + (global.turn % 2 == 0 ? "Grey" : "Black");
draw_text_transformed(x+sprite_width/4,y+sprite_height/10,turn_string, image_xscale, image_yscale, 0);

if (global.won != 0) {
	turn_string = "Winner is ";
	if (global.won == 1) turn_string += "Grey";
	if (global.won == 2) turn_string += "Black";
	if (global.won == 3) turn_string += "Both";
	
	draw_set_color(c_green);
	draw_text_transformed(x+sprite_width/6.5,y+4*sprite_height/7,turn_string, image_xscale, image_yscale, 0);
	draw_set_color(c_black);
}

if (!global.edit){
	var me_string = "I am "+(global.playas==0?"grey":"black");
	draw_text_transformed(x+sprite_width/4,y+sprite_height/2,me_string, image_xscale, image_yscale, 0);
}