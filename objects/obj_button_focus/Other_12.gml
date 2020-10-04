/// @description Process clicking

// if right half, increase; left half, decrease
if (mouse_x - x < sprite_width / 2)
	changeValue(-1);
else
	changeValue(1);
