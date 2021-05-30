// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function textBox(textObj){
	if (!instance_exists(obj_textBox))
		with(instance_create_depth(x, y, 0, obj_textBox))
			tnPointer = textObj;
}


function TextNode(_text, _options, _next, _spd, _enterFunc, _leaveFunc) constructor {
	
	text = _text;
	next = _next;
	options = _options;
	spd = _spd;
	onenter = _enterFunc;
	onleave = _leaveFunc;
	
	setNext = function(__next){
		next = __next;
		return self;
	}
	
	addOption = function(name, pointer){	
		
		// initialize both to empty arrays if need be
		if (options == undefined)
			options = [];
		if (next == undefined)
			next = [];
		
		append(options, name);
		append(next, pointer);
		
		// make the length of the arrays the same
		while (array_length(options) > array_length(next))
			append(next, undefined);
		while (array_length(options) < array_length(next))
			append(options, undefined);
		
		return self;
	}
	
	updateOption = function(name, pointer){
		
		var ind = posInArray(options, name);
		
		// sanity check
		if (ind == -1) 
			show_error("updating unexistent pointer", true);	

		next[ind] = pointer;	
		return self;
	}
	
	setSpd = function(__spd){
		spd = __spd;
		return self;	
	}
	
	setLeave = function(__leaveFunc){
		// sanity check
		if (!is_method(__leaveFunc))
			show_error("onleave must be a function", true);
		
		onleave = __leaveFunc;
		return self;
	}
	
	setEnter = function(__enterFunc){
		// sanity check
		if (!is_method(__enterFunc))
			show_error("onleave must be a function", true);
			
		onenter = __enterFunc;
		return self;
	}
}
