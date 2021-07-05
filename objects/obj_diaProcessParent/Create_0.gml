/// @description Insert description here
// You can write your code in this editor


// logic for going to next TN
optionInd = 0;			// index of option chosen
textInd = 0;			// index of current text to draw up to
textSegInd = 0;			// index of current text segment on this text node
tnPointer = -1;			// the TextNode obj to follow
finishedText = false;	// var is true when all text segments are done displaying

// true if we haven't executed the first TNs enter function
executeFirstTNsEnter = true;	



// this function is called when we are loading in a new textSeg
setStyle = function(textSeg){

	// load in default stylization
	textS = 1				// number of characters per frame
	textFont = fnt_TNR;		// the font of text
	textC = c_white;		// color of text
	backC = c_black;		// background color behind text
	optionFont = fnt_TNR;	// font for the options
	optionC = c_gray;		// background color for options
	optionSelC = c_green;	// background color for selected option
	optionTextC = c_white;	// text color for options
	
	// overwrite the style if necessary
	if (textSeg == undefined) {
		if (tnPointer == -1) return;
		if (textSegInd >= array_length(tnPointer.textContent)) return;
		textSeg = tnPointer.textContent[textSegInd];
		if (textSeg == undefined) return;
	}
	
	var structVars = variable_struct_get_names(textSeg);
	for (var i=0; i<array_length(structVars); i++)
		if (variable_instance_exists(self, structVars[i]))
			variable_instance_set(
				self, structVars[i], 
				variable_struct_get(textSeg, structVars[i])
			)
}

setStyle();


// function called when we move to another text node
gotoNext = function(){
	
	if (tnPointer.onleave != undefined)
		tnPointer.onleave();
	
	tnPointer = tnPointer.getNextNode();
			
	if (tnPointer == undefined)
		instance_destroy();
	else if (tnPointer.onenter != undefined)
		tnPointer.onenter();
	
	finishedText = false;
	optionInd = 0;
	setStyle();
}
