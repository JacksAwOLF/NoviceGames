// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function start_sound(name, priority, loop){
	if (global.edit && !global.soundOn) exit;
	
	
	if (name == "error") 
		audio_play_sound(snd_error, priority, loop);	
	else if (name == "connected")
		audio_play_sound(snd_connected, 0, false);
	else if (name == "turn") 
		audio_play_sound(snd_your_turn, 0, false);
	else 
		show_error("Sound name \"" + name + "\" not recognized!", false);
}