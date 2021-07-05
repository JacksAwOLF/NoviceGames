/// @description 



// draw the background
draw_rectangle_color(
	backX, backY, backX+backW, backY+backH, 
	backC, backC, backC, backC, false
);


// draw the text
draw_set_font(textFont);
draw_text_ext_color(
	textX, textY, 
	string_copy(tnPointer.text, 1, textInd),
	textH, textW, textC, textC, textC, textC, 1
);


// draw the options
if (finishedText && tnPointer.options != undefined){
	
	var arr = tnPointer.options;
	var n = array_length(arr);
	
	draw_set_font(optionFont);	
	
	// precalculate the option widths for drawing
	if (optionW == -1){
		optionW = [];
		optionWSum = 0;
		for (var i=0; i<n; i++){
			var ww = string_width(arr[i]) + optionTextBufferX * 2;
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
	
		
		var color = (optionInd == i ? optionSelC : optionC);
		
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
		draw_text_color(
			xx + optionTextBufferX, 
			optionY + optionTextBufferY, 
			arr[i],
			optionTextC,  optionTextC, optionTextC, optionTextC, 1
		);
		
		// update to next x coordinate of option
		xx += optionW[i] + optionWSep;
	}
		
} else optionW = -1;