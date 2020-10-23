/// @description Insert description here
// You can write your code in this editor





var t = global.grid[pos];
var formId = t.soldier.formation;


var arr = global.formation[formId].tiles;
for (var i =0; i<array_length(arr); i++){
	if (arr[i].soldier == -1)
		continue
	arr[i].soldier.formIndication = false;
	arr[i].soldier.formation = -1;
}


// replace this with a ds_list in the future
global.formation[formId] = -1;


erase_blocks(true);
formationReset();