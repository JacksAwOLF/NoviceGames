/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

var text = [], len = 0;
text[len++] = ("Fog(f): " + (global.fogOn ? "On" : "Off"));
text[len++] = ("Huts(h): " + (global.hutOn ? "On" : "Off"));
text[len++] = ("Sounds(s): " + (global.soundOn ? "On" : "Off"));

for (var i = 0; i < len; i++)
	draw_text_transformed(x+10*image_xscale,y+(i*20+10)*image_yscale,text[i],0.8,0.8,0);