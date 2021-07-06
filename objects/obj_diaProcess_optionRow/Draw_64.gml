/// @description 



// draw the background

var backC = frameStyle.backC;

draw_rectangle_color(
	backX, backY, backX+backW, backY+backH, 
	backC, backC, backC, backC, false
);


// calculate positioning of each text in textSeg
// this is done while loading in the text node

// draw the text
event_inherited()



// draw the options
if (finishedText && textSegInd+1==array_length(tnPointer.textContent) &&
	is_array(availableOptions) && array_length(availableOptions) > 0){
	
	var arr = availableOptions, n = array_length(availableOptions);
	
	draw_set_font(frameStyle.optionFont);	
	
	// precalculate the option widths for drawing
	if (optionW == -1){
		optionW = [];
		optionWSum = 0;
		for (var i=0; i<n; i++){
			var ww = string_width(arr[i].text) + optionTextBufferX * 2;
			optionWSum += ww;
			append(optionW, ww);
		}
		optionWSep = (backW-2*optionX-optionWSum) / (n+1);
		
		// sanity check
		if (optionWSep < 0)
			show_error("option texts too long", false);
	}
	
	
	var xx = optionWSep;
	
	for (var i=0; i<n; i++){
	
		var color = (optionInd == i ? frameStyle.optionSelC : frameStyle.optionC);
		
		// the option background box
		draw_rectangle_color(
			xx,
			optionY,
			xx + optionW[i],
			optionY + optionH,
			color, color, color, color,
			false
		);
			
		// draw the text on that option
		var optionTextC = frameStyle.optionTextC;
		draw_text_color(
			xx + optionTextBufferX, 
			optionY + optionTextBufferY, 
			arr[i].text,
			optionTextC,  optionTextC, optionTextC, optionTextC, 1
		);
		
		// update to next x coordinate of option
		xx += optionW[i] + optionWSep;
	}
		
} else optionW = -1;