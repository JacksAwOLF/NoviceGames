/// @description Insert description here


var isNotAnimating = (path_index == -1);	// whether we process user input

if (isNotAnimating){
	
	var leftHeldDown = keyboard_check(vk_left) || keyboard_check(ord("A")),
		rightHeldDown = keyboard_check(vk_right) || keyboard_check(ord("D")),
		horDir = rightHeldDown - leftHeldDown;
		
	if (horDir == 0){		// no horizontal direction is specified
		// friction
		
		// decrease absolute speed by horDccel if its bigger than 0
		var horSpdSign = (horSpd >= 0 ? 1 : -1);
		horSpd = max(abs(horSpd) - horDccel, 0) * horSpdSign;
		
	} else {
		// acceleration
		
		// start increasing velocity from 0 when changing direction
		if ((horSpd < 0) != (horDir < 0))
			horSpd = 0;
		
		// increase speed in the direction of key press
		// within the range of [-horMaxSpd, horMaxSpd];
		horSpd = max(-horMaxSpd, min(horSpd + horDir * horAccel, horMaxSpd));
	}
	
	
	
	// make sure that the player character stays within bounds
	var width = sprite_get_width(sprite_index) / 2;
	x = max(room + width, min(room_width - width, x+horSpd));
}

else {
	horSpd = 0;	
}
