

mouseIn = point_in_rectangle(mouse_x, mouse_y, x, y, x+width, y+height);

if (mouseIn){
	if (mouse_x <  midline){
		//midline = x+width*2/3;
		if (mouse_x < x+(midline-x)/2) imgstate = 1;
		else imgstate = 3
	}
	else {
		imgstate = 2;
		//midline = x+width/2;
	}
} else imgstate  = 0;
	