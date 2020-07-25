/// @description Insert description here
// You can write your code in this editor

draw_self();

draw_set_color(c_red);
draw_text(x, y+sprite_height/3, string(global.soldier_vars[ind]));

draw_text_ext(x, y+64, text, -1, 64);
draw_set_color(c_black);

