/// @description Calculate textPos before inheriting

// draw the text segments on the screen
// according to the coordinates in textPos = {xx: ..., yy: ...}

if (textPos == -1) exit;

for (var i=0; i<=textSegInd; i++){
	
	var textSeg = tnPointer.textContent[i];
	
	// get text to draw for this textSegment
	var text = textSeg.text;
	if (i == textSegInd) 
		text = string_copy(text, 1, textInd);
	
	// set styles
	setTextStyle(textSeg);
	draw_set_font(textStyle.textFont);
	
	// draw that text at positions specified by child
	var cc = textStyle.textC;
	draw_text_ext_color(
		textPos[i].xx, textPos[i].yy,
		text, textPos[i].hh, textPos[i].ww,
		cc, cc, cc, cc, 1
	);
}
		
