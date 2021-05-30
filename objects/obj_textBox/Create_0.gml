/// @description Initialize Variables



viewW = camera_get_view_width(view_camera[0]);
viewH = camera_get_view_height(view_camera[0]);




// the background rectangle behind the text

	// color... might want to replace with sprite in the future
backC = c_black;

	// position
backX = 0;
backY = viewH * 0.75;

	// size
backW = viewW - 2 * backX;
backH = viewH - backY;





// the text on top of the background

	// style
textFont = fnt_TNR;
textC = c_white;

	// position
textX = backX + 0.05 * backW;
textY = backY + 0.1 * backH;

	// size
textW = backW * 0.9;
draw_set_font(textFont);
textH = string_height("ABCDEFGHIJKLMNOPQRSTUVWXYZ");

	
	

textS = 1;		// default speed of text to draw
textInd = 0;





// the options that will sometimes show up

	// style
optionFont = fnt_TNR;
optionC = c_gray;
optionSelC = c_green;

	// option text position relative from the option rectangle
optionTextBufferX = 8;
optionTextBufferY = 6;

	// option rectangle size
draw_set_font(textFont);
optionH = string_height("ABCDEFGHIJKLMNOPQRSTUVWXYZ") + 2*optionTextBufferY;
optionW = -1;	// width is determined by length of option value, preprocess

	// position
optionX = textX;
optionY = backY + backH - optionH - backH * 0.08;

	// index of option chosen
optionInd = 0;

	



// the TextNode obj to follow
tnPointer = -1;

// var is true when textInd == length of text
finishedText = false;


executeFirstTNsEnter = true;

// function called when we move to another text node
gotoNext = function(nextPointer){
	
	if (tnPointer.onleave != undefined)
		tnPointer.onleave();
	
	tnPointer = nextPointer;
			
	if (tnPointer == undefined)
		instance_destroy();
	else if (tnPointer.onenter != undefined)
		tnPointer.onenter();
		
	textInd = 0;
	finishedText = false;
	optionW = -1;
	optionInd = 0;
}