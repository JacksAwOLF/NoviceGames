function array() {
	var arr=[];
	for (var i=0; i<argument_count; i+=1){
		arr[i] = argument[i];
	}
	return arr;
}


function append(arr, val){
	//debug("before append", arr, val);
	if (!is_array(val)) arr[array_length(arr)] = val;
	else {
		for (var i=0; i<array_length(val); i++)
			arr[array_length(arr)] = val[i]
	}
	
	//debug("after append", arr, val);
	return arr;
}	
