function array() {
	var arr=[];
	for (var i=0; i<argument_count; i+=1){
		arr[i] = argument[i];
	}
	return arr;
}


function append(arr, val){
	//debug("before append", arr, val, !is_array(val));
	if (!is_array(val)) arr[array_length(arr)] = val;
	else {
		for (var i=0; i<array_length(val); i++)
			arr[array_length(arr)] = val[i]
	}
	
	//debug("after append", arr, val, !is_array(val));
	return arr;
}	


function posInArray(argument0, argument1) {
	for (var i=0; i<array_length(argument0); i++)
		if (argument0[i] == argument1)
			return  i;
	return -1;
}
