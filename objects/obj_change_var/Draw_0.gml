/// @description Insert description here
// You can write your code in this editor

if (state == VisualState.inactive) exit;

draw_self();


var drawing = string(global.soldier_vars[ind]);
if (text == "Class"){
	switch(global.soldier_vars[ind]){
		case Classes.melee:
			drawing = "M";
			break;
		case Classes.range:
			drawing = "R";
			break;
		case Classes.scout:
			drawing = "S";
			break;
	}
}

if (text == "Win") {
	switch(global.soldier_vars[ind]) {
		case 0: drawing = "H"; break;
		case 1: drawing = "T"; break;
		case 2: drawing = "S"; break;
		default: drawing = "?"; break;
	}
}


var offset = sprite_width/8;

draw_set_color(c_red);
draw_text_transformed(x+offset, y+sprite_height/3+offset, drawing, image_xscale, image_yscale, 0);

draw_set_font(font_soldier_vars);
draw_text_ext_transformed(x, y+64*image_yscale+offset, text, -1, 64, image_xscale, image_yscale, 0);
draw_set_font(font0);

draw_set_color(c_black);

