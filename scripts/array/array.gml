function array() {
	var arr=[];
	for (var i=0; i<argument_count; i+=1){
		arr[i] = argument[i];
	}
	return arr;
}

function remove_from_array(arr, val) {
	if (arr == -1) 
		return;
		
	for (var i = 0; i < array_length(arr); i++)
		if (arr[i] == val) 
			arr[@ i] = -1;
}

function add_into_array(arr, val) {
	if (arr == -1) 
		show_error("Parameter passed into add_an_array is not an array!", false);
	
	for (var i = 0; i < array_length(arr); i++) {
		if (arr[i] == -1) {
			arr[@ i] = val;
			return i;
		}
	}
	
	arr[@ array_length(arr)] = val;
	return array_length(arr) - 1;
}

function append(arr, val){
	if (!is_array(val)) arr[@ array_length(arr)] = val;
	else 
		for (var i=0; i<array_length(val); i++)
			arr[@ array_length(arr)] = val[i]
}	

function get_size_array(arr){
	var size  = 0;
	for (var i=0; i<array_length(arr); i++)
		if (arr[i] != -1)
			size++;
	return size;
}

function get_front_array(arr){
	for (var i=0; i<array_length(arr); i++)
		if (arr[i] != -1)
			return arr[i];
}

function posInArray(arr, val) {
	for (var i=0; i<array_length(arr); i++)
		if (arr[i] == val)
			return  i;
	return -1;
}
