/// @description 

if (executeFirstTNsEnter){
	executeFirstTNsEnter = false;
	if (tnPointer!=undefined && tnPointer.onenter != undefined)
		tnPointer.onenter();
}


var nextPage = keyboard_check_pressed(vk_enter);
var finishText = keyboard_check_pressed(vk_space);



if (finishedText){
	
	if (tnPointer.options != undefined){
		
		// update optionInd
		var subtract = keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A")),
			add = keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D")),
			delta = add - subtract,
			n = array_length(tnPointer.options);
		optionInd = (optionInd + delta + n) % n;
		
		// go to next page according to optionInd if needed
		if (nextPage) gotoNext(tnPointer.next[optionInd]);
	} 
	
	// if no options for this page, go to next page if needed
	else if (nextPage) gotoNext(tnPointer.next)
}




// if not finished displaying text
else {
	
	var n = string_length(tnPointer.text);
	
	// update textInd
	if (finishText) textInd = n;
	else if (tnPointer.spd != undefined)
		textInd += tnPointer.spd;
	else textInd += textS;
	
	// check for finish
	if (textInd >= n){
		finishedText = true;
		textInd = n;
	}
	
}