/// @description Insert description here
// You can write your code in this editor

hor = -1
ver = -1
load_file = -1

if global.loadMap 
	load_file = get_string_async("Enter file name: ", "hi.txt");
else  
	hor = get_integer_async("How many empty tiles left to right?", 10);



