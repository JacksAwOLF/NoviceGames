/// @description Insert description here
// You can write your code in this editor


// is this mouse release?

var t = global.grid[pos];
var arr =  t.possFormStructs[t.whichFormStruct].soldiers;
var n = array_length(global.formation);
for (var i=0; i<array_length(arr); i++)
	arr[i].formation =  n;


global.formation[ n ] = t.possFormStructs[t.whichFormStruct];

erase_blocks(true);
global.selectedSoldier = -1;
formationReset();