/// @description Insert description here
// You can write your code in this editor

if (async_load == -1){
		
	global.selectedSoldier = -1;
	soldier_erase_attack();
	soldier_erase_move();
		
	fileName = get_string_async("Name of file: ", "hi.txt");
}