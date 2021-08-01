/// @description Insert description here
// You can write your code in this editor

var onGround = place_meeting(x, y + 1, obj_wall_plt)
var jump = keyboard_check_pressed(jumpKey) && 
	(onGround || (curJumps != maxJumps && curJumps != 0) );
	
if (onGround) {
	verSpd = 0;
	curJumps = 0;
} else {
	verSpd = min(verSpd + grav, maxVerSpd);
	if (verSpd<0 && curJumps != 0 && keyboard_check_released(jumpKey))
		verSpd = 0
}

if (jump) {
	verSpd = -jumpStrength[curJumps];
	curJumps += 1;
}


var horDir = (keyboard_check(rightKey) - keyboard_check(leftKey))
debug(horDir, horSpd)
if (horDir != 0) {
	horSpd += horDir * horInc;
	horSpd = min(horSpd, maxHorSpd);
	horSpd = max(horSpd, -maxHorSpd);
} else {
	var horAbsSpd = abs(horSpd);
	horAbsSpd = max(horAbsSpd - horDec, 0);
	horSpd = sign(horSpd) * horAbsSpd;
}
debug(horDir, horSpd)
debug("------")





var hSign = sign(horSpd);
for (var i = 0; abs(i) < abs(horSpd); i += hSign) {
	if (place_meeting(x + hSign, y, obj_wall_plt))
		break; 
	x += hSign
}

var vSign = sign(verSpd);
for (var i = 0; abs(i) < abs(verSpd); i += vSign) {
	if (place_meeting(x, y + vSign, obj_wall_plt))
		break; 
	y += vSign
}