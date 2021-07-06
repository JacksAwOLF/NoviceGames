// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

enum DialogueTypes
{
	OptionRow
}

function textBox(textObj, type){
	var typeToObj = [obj_diaProcess_optionRow];
	if (!instance_exists(obj_diaProcessParent))
		with(instance_create_depth(x, y, 0, typeToObj[type]))
			tnPointer = textObj;
}

// ------------------------------------------------
// Dialogue system structure definitions begin here
// ------------------------------------------------

// TextSegment: no constructor to be used
//		color, speed, font, etc...

function TextEdge(_nextIndex, _isAvailable) constructor {
	nextIndex = _nextIndex;
	isAvailable = is_method(_isAvailable) ? _isAvailable : true_func;
}


function DialogueOption(_textContent, _textEdges, _appearCondition) constructor {
	textContent = _textContent;
	textEdges = is_array(_textEdges) ? _textEdges : [];
	appearCondition = is_method(_appearCondition) ? _appearCondition : true_func;
	
	getNextNode = function() {
		for (var i = 0; i < array_length(textEdges); i++) {
			if (textEdges[i].isAvailable()) {
				if (textEdges[i].nextIndex == -1)
					return undefined;
				return global.textGraph[textEdges[i].nextIndex];
			}
		}
		
		// TextNode should proceed on checking its own textEdges
		return -2;
	}
	
	setNextNode = function(__getNextNode) {
		// sanity check
		if (!is_method(__getNextNode))
			show_error("onEnter must be a function", true);
			
		getNextNode = __getNextNode;
		return self;
	}
}


function TextNode(_speakerName, _spriteName, _spriteInd, _textContent, _textOptions, _textEdges) constructor {
	
	speakerName = _speakerName;
	spriteName = _spriteName;
	spriteInd = _spriteInd;

	textContent = is_array(_textContent) ? _textContent : []; // array of TextSegments to be displayed
	textOptions = is_array(_textOptions) ? _textOptions : []; // array of DialogueOptions to be shown
	textEdges = is_array(_textEdges) ? _textEdges : [];		  // array of TextEdges to be considered
	
	onEnter = blank_func;
	onLeave = blank_func;
	
	// default getNext iterates through edges sequentially
	// and chooses first one whose condition is true
	getNextNode = function() {
		if (array_length(textOptions) > 0) {
			var chosenOption = obj_diaProcessParent.optionInd;
			var options = obj_diaProcessParent.availableOptions;
			
			if (is_array(options) && chosenOption >= 0 && chosenOption < array_length(options)) {
				var optionIndex = options[chosenOption].index; 
				var nextNode = textOptions[optionIndex].getNextNode();

				if (nextNode != -2)
					return nextNode;
			}
		}
		
		for (var i = 0; i < array_length(textEdges); i++) {
			if (textEdges[i].isAvailable()) {
				if (textEdges[i].nextIndex == -1)
					return undefined;
				return global.textGraph[textEdges[i].nextIndex];
			}
		}
	}
	
	
	
	// functions to add options into their respective arrays
	addSegment = function(textSegment) {
		textContent[array_length(textContent)] = textSegment;
		return self;
	}
	addEdge = function(textEdge) {
		textEdges[array_length(textEdges)] = textEdge;
		return self;
	}
	addOption = function(dialogeOption) {	
		textOptions[array_length(textOptions)] = dialogeOption;
		return self;
	}
	
	
	
	//  setter functions for function variables
	setLeave = function(__leaveFunc){
		// sanity check
		if (!is_method(__leaveFunc))
			show_error("onLeave must be a function", true);
		
		onLeave = __leaveFunc;
		return self;
	}
	setEnter = function(__enterFunc){
		// sanity check
		if (!is_method(__enterFunc))
			show_error("onEnter must be a function", true);
			
		onEnter = __enterFunc;
		return self;
	}
	setGetNextNode = function (__getNextNode) {
		// sanity check
		if (!is_method(__getNextNode))
			show_error("onEnter must be a function", true);
			
		getNextNode = __getNextNode;
		return self;
	}
}
