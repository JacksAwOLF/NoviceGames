/// @description Insert description here
// You can write your code in this editor

if (client_connected(false) == 1) exit;

if (async_load == -1){
		
	global.selectedSoldier = -1;
	erase_blocks();
		
	fileName = get_string_async("Name of file: ", "hi.txt");
}
