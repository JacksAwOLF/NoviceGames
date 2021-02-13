/// @description Toggle Fog

if (!global.edit) exit;

if (global.fogOn) {
	for (var i = 0; i < array_length_1d(global.grid); i++)
		global.grid[i].hide_soldier = false;
	global.fogOn = false;
	
} else {
	global.fogOn = true;
	update_fog();
	
}
	
