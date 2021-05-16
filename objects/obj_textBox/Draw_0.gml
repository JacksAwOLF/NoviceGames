/// @description Insert description here
// You can write your code in this editor

debug("drawing code of text box");

// draw the text screen on the bottom
var rectH = 0.2 * room_height;
draw_set_color(c_white);
draw_rectangle(0, rectH, room_width, room_height, false);
draw_set_color(c_black);
draw_rectangle(0, rectH, room_width, room_height, true);


// the box that displays text
var textX=0.1, textY=0.1, textH=0.5;

var tyy = room_height-rectH+rectH*textY;

	draw_set_color(c_red); 
	draw_rectangle(textX*room_width, 
		tyy,room_width*(1-textX), 
		tyy + rectH * textH, true);
	
draw_set_font(fnt_TNR);
draw_text(room_width*textX, tyy, "testing string this \n is a big test");
