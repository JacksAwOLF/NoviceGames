/// @description Insert description here
// You can write your code in this editor


// logic for going to next TN
optionInd = 0;			// index of option chosen
textInd = 0;			// index of current text to draw up to
textSegInd = 0;			// index of current text segment on this text node
tnPointer = -1;			// the TextNode obj to follow
finishedText = false;	// var is true when all text segments are done displaying

// data to be displayed
availableOptions = [];  // stores {text, index} of all options of current textNode that can appear
drawPastSegments = [];  // array of functions that draws previous text segments

// true if we haven't executed the first TNs enter function
executeFirstTNsEnter = true;	


// this function is called when we are loading in a new textSeg
setTextStyle = function(textSeg){

	// load in default stylization
		// specific to a single text segment
	textStyle = {
		textS: 1,				// number of characters per frame
		textFont: fnt_TNR,		// the font of text
		textC: c_white			// color of text
	};
	
	// overwrite textStyle if necessary
		// if undefined argument, set it to current segind
	if ( textSeg == undefined && tnPointer != -1 && 
		textSegInd < array_length(tnPointer.textContent) )
		textSeg = tnPointer.textContent[textSegInd];
		// load it in if it is defined
	if (textSeg != undefined && variable_struct_exists(textSeg, "style"))
		loadStruct(textStyle, textSeg.style, false);
}

setFrameStyle = function(textNode){
	
	// load in default stylization
		// general across this text node
	frameStyle = {
		backC: c_black,			// background color behind text
		optionFont: fnt_TNR,	// font for the options
		optionC: c_gray,		// background color for options
		optionSelC: c_green,	// background color for selected option
		optionTextC: c_white,	// text color for options
	}
	
	// overwrite textStyle if necessary
		// if undefined argument, set it to current segind
	if ( textNode == undefined && tnPointer != -1 )
		textNode = tnPointer;
		// load it in if it is defined
	if (textNode != undefined && textNode.style != undefined)
		loadStruct(frameStyle, textNode.style, false);
}

setStyle = function(){
	setTextStyle();
	setFrameStyle();
}

setStyle();

// function that updates available options of current textNode
updateOptions = function() {
	availableOptions = [];
	if (is_array(tnPointer.textOptions)) {
		for (var i = 0; i < array_length(tnPointer.textOptions); i++) {
			if (tnPointer.textOptions[i].appearCondition()) {
				availableOptions[array_length(availableOptions)] = 
					{
						text: tnPointer.textOptions[i].textContent, 
						index: i
					};
			}
		}
	}
}


// function called to initialize a new tnode
initTNode = function(){
	
	if (tnPointer == -1 || tnPointer == undefined) return;
	tnPointer.onEnter();
	updateOptions();
	calculateTextSegPositions();
	setFrameStyle();
	// caculateOptionButtonPositions();
	
	finishedText = false;
	optionInd = 0;
	textSegInd = 0;
	textInd = 0;
}

// function called when we move to another text node
gotoNext = function(){
	
	if (tnPointer.onLeave != undefined)
		tnPointer.onLeave();
	
	tnPointer = tnPointer.getNextNode();
			
	if (tnPointer == undefined) {
		instance_destroy();
		return;
	}
	
	initTNode();
}



textPos = -1;



// this function calculates the positions of
// text segments in this tnPointer and stores
// them in textPos
calculateTextSegPositions = function(){
	
	if (tnPointer == -1 || tnPointer == undefined) return;
	
	var curX = textX, curY = textY;
	var arr = tnPointer.textContent;
	var n = array_length(arr);
	textPos = array_create(n);
	
	for (var i=0; i<array_length(arr); i++){
		textPos[i] = {
			xx: curX, yy: curY,	
			hh: textH, ww: textW,
		}
		
		setTextStyle(arr[i]);
		draw_set_font(textStyle.textFont);
		curY += string_height_ext(arr[i].text, textH, textW);
	}
}