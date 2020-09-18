/// @description Insert description here
// You can write your code in this editor


if (txt != ""){
	
	if (premsg != txt){
		alpha =  1;
		xx = (room_width-string_width(txt))/2;
		yy = room_height/10*8;
		y_delta = 1.5;
	}

	if (count % steps == 0){
		alpha -= alpha_delta;
		yy -= y_delta;
		y_delta -= y_delta_delta;
		if (alpha <= 0) {
			txt = "";
			if (die){

				if (socket != -1) network_destroy(socket);
				if (osocket != -1) network_destroy(osocket);
				
				instance_destroy();
				room_goto(rm_start_screen)
			}
		}
	}
	
	
	var spr = spr_orange;
	draw_sprite_ext(spr, 0, xx, yy, string_width(txt)/sprite_get_width(spr), string_height(txt)/sprite_get_height(spr), 0, c_white, alpha );
	
	draw_set_color(c_black);
	draw_text(xx, yy, txt);
	
	count++;
}




premsg = txt;