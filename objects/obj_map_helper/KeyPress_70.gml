/// @description Insert description here
// You can write your code in this editor
if (!global.edit) exit;

if (global.fog_on) {
	for (var i = 0; i < array_length_1d(global.grid); i++)
		global.grid[i].hide_soldier = false;
	global.fog_on = false;
	
} else {
	global.fog_on = true;
	update_fog();
	
}
	