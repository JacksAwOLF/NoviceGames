// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function blank_func() {
	
}

function true_func() {
	return true;
}

function false_func() {
	return false;
}


function loadStruct(structInto, structFrom, addNewEntry){
	if (addNewEntry == undefined) addNewEntry = false;
	
	var structVars = variable_struct_get_names(structFrom);
	for (var i=0; i<array_length(structVars); i++)
		if (addNewEntry || variable_struct_exists(structInto, structVars[i]))
			variable_struct_set(
				structInto, structVars[i], 
				variable_struct_get(structFrom, structVars[i])
			)
}