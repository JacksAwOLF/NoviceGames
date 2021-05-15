/// @description Insert description here
// You can write your code in this editor


// set image_index according to delta position
// walking animation has 8 frames per movement
// image order: 8 down, 8 up, 8 left, 8 right
var framesPerAnimation = 8;

if (prevX == x && prevY == y){		// stationary
	imgIndCounter = 0;
	image_index = floor(image_index/framesPerAnimation)
					*framesPerAnimation;
} else{
	
	// imgIndCounter is the index of the animation
	imgIndCounter += imgIndCounterSpd;
	if (imgIndCounter >= framesPerAnimation)	// :( mod doesn't work 
		imgIndCounter -= framesPerAnimation;	// with floating points
	
	// constant specifies which animation we are on
	var const = prevY!=y ? (prevY<y?0:1) : (prevX>x?2:3);
	
	image_index = imgIndCounter + const*framesPerAnimation;
}


draw_self();

prevX = x;
prevY = y;