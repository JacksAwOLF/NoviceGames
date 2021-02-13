/// @description Insert description here
// You can write your code in this editor


var t = global.grid[pos];


var arr = t.possFormStructs[t.whichFormStruct].tiles;
for (var i=0; i<array_length(arr); i++)
	arr[i].soldier.formIndication = false;

t.whichFormStruct = (t.whichFormStruct+1)%array_length(t.possFormStructs);

arr = t.possFormStructs[t.whichFormStruct].tiles;
for (var i=0; i<array_length(arr); i++)
	arr[i].soldier.formIndication = true;
