/// @param array
/// @param to_find

function posInArray(argument0, argument1) {
	for (var i=0; i<array_length_1d(argument0); i++)
		if (argument0[i] == argument1)
			return  i;
	return -1;
}
