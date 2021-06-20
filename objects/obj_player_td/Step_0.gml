/// @description YOHOHO

right = keyboard_check(ord("D"))
left = keyboard_check(ord("A"))
up = keyboard_check(ord("W"))
down = keyboard_check(ord("S"))

if (still){

	moving_sprite_index = 0;

	if (down) moving_direction = 0
	else if (up) moving_direction = 1
	else if (left) moving_direction = 2
	else if (right) moving_direction = 3
	
	if ((right-left!=0) || (down-up)!=0) still = false;
} 

if (!still){
	
	// move the sprite
	if (moving_direction < 2) y += (moving_direction*-2+1) * moving_spd;
	else x += (moving_direction*2-5) * moving_spd;	
	
	// animate the sprite
	moving_sprite_index += 1;
	
	if (moving_sprite_index == 6*delay){
		moving_sprite_index = 0;
		still = true;
	}
	
}