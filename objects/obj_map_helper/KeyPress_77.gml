/// @description Insert description here
// You can write your code in this editor

if (audio_is_playing(bgm)) {
	audio_stop_sound(bgm);
} else {
	audio_play_sound(bgm, 0, true);	
}