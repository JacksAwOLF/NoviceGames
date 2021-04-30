/// @description Insert description here


var isNotAnimating = (path_index == -1);	// whether we process user input

if (isNotAnimating){
	
	var leftHeldDown = keyboard_check(vk_left),
		rightHeldDown = keyboard_check(vk_right),
		horDir = rightHeldDown - leftHeldDown;
		
	if (horDir == 0){ // no key is pressed
		// friction?
		// decrease absolute speed by horDccel if its bigger than 0
		var horSpdSign = (horSpd >= 0 ? 1 : -1);
		horSpd = max(abs(horSpd) - horDccel, 0) * horSpdSign;
	} else {
		// acceleration?
		// increase speed in the direction of key press
		// within the range of [-horMaxSpd, horMaxSpd];
		horSpd = max(-horMaxSpd, min(horSpd + horDir * horAccel, horMaxSpd));
	}
	
	x += horSpd;
}

else {
	horSpd = 0;	
}

