/// @description Insert description here
// You can write your code in this editor


var i_d = ds_map_find_value(async_load, "id");

if i_d == load_file {
	if ds_map_find_value(async_load, "status")
		load_map_from_file(string(ds_map_find_value(async_load, "result")));
	else room_goto(rm_start_screen);
}

