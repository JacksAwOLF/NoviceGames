/// @description Insert description here
// You can write your code in this editor

event_inherited();



if (imgstate%2){
	draw_set_font(font_menu_text3);
	
	var t1 = "white", t2 = "black";
	var mid = (midline-x)/2;
	
	draw_set_color(c_black);
	if (mouse_x < x+mid) draw_set_color(c_subtext);
	draw_text(x+(mid-string_width(t1))/2, yy, t1)
	
	draw_set_color(c_black);
	if (mouse_x >= x+mid) draw_set_color(c_subtext);
	draw_text(x+mid+(mid-string_width(t2))/2, yy, t2)
	
	draw_set_font(font0);
}