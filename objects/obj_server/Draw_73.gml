/// @description Insert description here
// You can write your code in this editor


if (txt != ""){
	
	
	var cam = view_get_camera(0);
	
	if (premsg != txt){
		alpha =  1;
		
		
	
		xx = camera_get_view_x(cam) + (camera_get_view_width(cam)-string_width(txt))/2;
		yy = camera_get_view_y(cam) + (camera_get_view_height(cam)/5);
		
		
		//debug(camera_get_view_width(cam), camera_get_view_height(cam), camera_get_view_x(cam), camera_get_view_y(cam))
		
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
	var tw = string_width(txt), th = string_height(txt);
	
	draw_sprite_ext(spr, 0, xx, yy, 
		tw/sprite_get_width(spr), 
		th/sprite_get_height(spr), 0, c_white, alpha );
	
	draw_set_color(c_black);
	/*draw_text_ext_transformed(xx, yy, txt, 5, 
		tw / room_width * camera_get_view_width(cam),
		view_get_wport(0)/ camera_get_view_width(cam) , 
		view_get_hport(0)/ camera_get_view_height(cam) ,  0);*/
		
	draw_text(xx, yy, txt);
	
	count++;
}




premsg = txt;