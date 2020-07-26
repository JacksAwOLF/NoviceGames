/// @description Insert description here
// You can write your code in this editor

mouseIn = x <= mouse_x && mouse_x <= x+sprite_width
	&& y <= mouse_y && mouse_y <= y+sprite_height;
	
if (mouseIn){
	if (async_load == -1 and mouse_check_button_released(mb_left)){
		
		debug("fire!!!")
		fire = false;
		fileName = get_string_async("Name of file: ", "hi.txt");
		
	}
} else {
	fire = true;
}

