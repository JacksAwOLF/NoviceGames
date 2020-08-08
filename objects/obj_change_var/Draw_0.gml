/// @description Insert description here
// You can write your code in this editor

if (state == VisualState.inactive) exit;

draw_self();

draw_set_color(c_red);
draw_text_transformed(x, y+sprite_height/3, string(global.soldier_vars[ind]), image_xscale, image_yscale, 0);

draw_text_ext_transformed(x, y+64*image_yscale, text, -1, 64, image_xscale, image_yscale, 0);
draw_set_color(c_black);

