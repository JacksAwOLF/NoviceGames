/// @description Insert description here
// You can write your code in this editor

mouseIn = x <= mouse_x && mouse_x <= x+sprite_width
	&& y <= mouse_y && mouse_y <= y+sprite_height;
	
if (mouseIn){
	if (fire and mouse_check_button_pressed(mb_left)){
		
		

		
		fileName = get_string_async("Name of file: ", "hi.txt");
		fire = false;
	}
} else {
	fire = true;
}

