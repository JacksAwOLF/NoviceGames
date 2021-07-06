/// @description 

if (tnPointer != -1) {
	
	// this script only runs once
	// cant be in create event because 
	// tnPointer doesn't get assigned until after
	// the create event is done running
	if (executeFirstTNsEnter){
		executeFirstTNsEnter = false;
	
		if (tnPointer.onEnter != undefined)
			tnPointer.onEnter();
		
		initTNode();
	}


	var nextPage = keyboard_check_pressed(vk_enter);
	var finishText = keyboard_check_pressed(vk_space);


	if (finishedText){
	
		if (is_array(availableOptions) && array_length(availableOptions) > 0){
		
			// update optionInd
			var subtract = keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A")),
				add = keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D")),
				delta = add - subtract,
				n = array_length(availableOptions);
			optionInd = (optionInd + delta + n) % n;
		
			// go to next page according to optionInd if needed
			if (nextPage) gotoNext();
		} 
	
		// if no options for this page, go to next page if needed
		else if (nextPage) gotoNext();
	}


	// if not finished displaying text
	else {
	
		var n_textSeg = array_length(tnPointer.textContent);
		var n_char = string_length(tnPointer.textContent[textSegInd].text);
	
		// increment textInd for this textSeg
		if (finishText) textInd = n_char;
		else textInd = min(textInd + textStyle.textS, n_char);
	
		// check if we move to next textSeg or finished all textSegs
		if (textInd == n_char){
			if (textSegInd+1 < n_textSeg){
				textSegInd += 1;
				textInd = 0;
			} else finishedText = true;
		}
	
	}
}