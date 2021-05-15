/// @description Insert description here
// You can write your code in this editor

interact = function() 
{
	//audio_play_sound(snd_ayame, 1, false);
	
	if (!instance_exists(obj_textBox)){
		
		debug("before instance creation");
		debug(instance_exists(obj_textBox));
		debug(instance_exists(obj_disbandFormation));
		
		with(instance_create_depth(obj_textBox,0,0,0))
			debug("created text box!", depth);
		
		debug("after instance creation");
		debug(instance_exists(obj_textBox));
		debug(instance_exists(obj_disbandFormation));
		
		if (instance_exists(obj_disbandFormation))
			instance_destroy(obj_disbandFormation);
			
		debug("finish instance creation");
		debug(instance_exists(obj_textBox));
		debug(instance_exists(obj_disbandFormation));
	}
}