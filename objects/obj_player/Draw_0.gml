/// @description Insert description here
// You can write your code in this editor


// set image_index according to delta position
// walking animation has 8 frames per movement
// image order: 8 down, 8 up, 8 left, 8 right

if (prevX == x && prevY == y){		// stationary
	imgIndCounter = 0;
	image_index -= image_index % 8;
} else{
	
	// imgIndCounter is the index of the animation
	imgIndCounter += imgIndCounterSpd;
	imgIndCounter %= 8;
	
	// constant specifies which animation we are on
	var const = prevY!=y ? (prevY<y?0:8) : (prevX>x?16:24);
	image_index = imgIndCounter + const;
}






draw_self();

prevX = x;
prevY = y;