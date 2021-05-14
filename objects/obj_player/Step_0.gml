/// @description Insert description here


var isNotAnimating = (path_index == -1);	// whether we process user input

if (isNotAnimating){
	
	var leftHeldDown = keyboard_check(vk_left) || keyboard_check(ord("A")),
		rightHeldDown = keyboard_check(vk_right) || keyboard_check(ord("D")),
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
		if ((horSpd < 0) != (horDir < 0))
			horSpd = 0;
		
		horSpd = max(-horMaxSpd, min(horSpd + horDir * horAccel, horMaxSpd));
	}
	
	// make sure that the player character stays within bounds
	x = max(0, min(room_width - sprite_get_width(sprite_index), x+horSpd));
}

else {
	horSpd = 0;	
}

