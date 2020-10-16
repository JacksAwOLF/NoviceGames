/// @description Insert description here
// You can write your code in this editor



var t = global.grid[pos];


var arr = global.formation[t.soldier.formation].soldiers;
for (var i =0; i<array_length(arr); i++)
	arr[i].formIndication = false;

// temp solution... trading mem for time now
global.formation[t.soldier.formation] = -1;

for (var i =0; i<array_length(arr); i++)
	arr[i].formation = -1;



with(global.grid[pos]) event_user(0);

formationReset();