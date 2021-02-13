/// @description Insert description here
// You can write your code in this editor


if (txt != ""){
	
	
	var cam = view_get_camera(0);
	var camw = camera_get_view_width(cam), camh = camera_get_view_height(cam);
	var pw = (camw/view_wport[0]), ph = (camh/view_hport[0]);
	var tw = string_width(txt) * pw , th = string_height(txt) * ph;
	
	
	if (premsg != txt){
		alpha =  1;
		
		xx = camera_get_view_x(cam) + (camw-tw)/2;
		yy = camera_get_view_y(cam) + (camh/5);
		
		
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
	
	
	draw_sprite_ext(spr, 0, xx, yy, 
		tw/sprite_get_width(spr), 
		th/sprite_get_height(spr), 0, c_white, alpha );
	
	draw_set_color(c_black);
	draw_text_transformed(xx, yy, txt, pw, ph, 0);
	
	count++;
}




premsg = txt;
