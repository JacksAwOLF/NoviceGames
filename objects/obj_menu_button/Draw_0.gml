/// @description Insert description here
// You can write your code in this editor

draw_set_font(font_menu_text);

draw_set_color(c_background);
draw_rectangle(x, y, x+width, y+height, false);

// the main text to draw
draw_set_color(c_maintext);
var yy = y+(height-string_height(maintext))/2;
maintext = string_upper(maintext);
if (imgstate != 0){
	yy = upy; maintext = string_lower(maintext);
	//draw_set_font(font_menu_text2);
}
draw_text(x+(width-string_width(maintext))/2, yy, maintext);


if (imgstate > 0){
	
	draw_set_font(font_menu_text2);
	
	var c1 = c_subtext, c2 = c_black;
	subtext1 = string_upper(subtext1);
	subtext2 = string_lower(subtext2);
	if (imgstate == 2){
		c1 = c_black; c2 = c_subtext; 
		subtext1 = string_lower(subtext1);
		subtext2 = string_upper(subtext2);
	}
	
	draw_set_color(c1);
	draw_text(x+((midline-x)-string_width(subtext1))/2, lowy, subtext1);
	
	draw_set_color(c2);
	draw_text(midline+((x+width-midline)-string_width(subtext2))/2, lowy, subtext2);	
}

draw_set_font(font0);