// global.formation => an array of structs
// each struct has a teamId and an array of tileId's (for now that's it)




// O(n) :((( but i guess its better than array and ds_list
function malList_findVal(list, val){
	var n = array_length(list), 
		found = false, i=0;
	for (; !found && i<n; i++)
		found = found && list[i] == val;
	return found ? i-1 : n;
}





function network_formation_create(teamId){
	var ind = malList_findVal(global.formation, -1);
	global.formation[ind] = {
		team: teamId, 
		tiles: [-1]
	};
	send_buffer(BufferDataType.formationCreate, array(teamId));
	return ind;
}

function network_malList_add(stringVar, val){
	var list = string_to_variable(stringVar);
	list[malList_findVal(list, -1)] = val;
	send_buffer(BufferDataType.malList_add, array(stringVar, val));
}

function malList_getSize(list){
	var n = array_length(list), count = 0;
	for (var i=0; i<n; i++)
		if (list[i] == -1) count++;
	return n-count;
}

function malList_getFirst(list){
	var n = array_length(list);
	for (var i=0; i<n; i++)
		if (list[i] != -1) return i;
}

// for update functions, if the newVal is -1 (deleting the value),
// returns true if the removed value is the last value in the 
function network_malList_updateValue(stringVar, oldVal, newVal){
	if (newVal == undefined) newVal = -1;
	var list = string_to_variable(stringVar);
	list[malList_findVal(list, oldVal)] = newVal;
	send_buffer(BufferDataType.malList_updateVal, array(stringVar, oldVal, newVal));
}

function network_malList_updateIndex(stringVar, ind, val){
	if (val == undefined) val = -1;
	var list = string_to_variable(stringVar);
	list[ind] = val;
	send_buffer(BufferDataType.malList_updateInd, array(stringVar, ind, val));
}



/*function network_formation_add_tile(formationId, tileId){
	global.formation[formationId].tiles[
		malList_findIndex(global.formation[formationId].tiles, -1)
	] = tileId;
	tileId.soldier.formation = formationId;
	send_buffer(BufferDataType.formationAddTile, array(formationId, tileId));
}

function network_formation_update_tile(formationId, tileId, value){
	global.formation[formationId].tiles[
		malList_findIndex(global.formation[formationId].tiles, tileId)
	] = value;
	send_buffer(BufferDataType.formationUpdateTile, array(formationId, tileId, value));
}

function network_formation_destroy(formationId){
	for (var i=0; i<array_length(global.formation[formationId].tiles); i++)
		global.formation[formationId].tiles[i].soldier.formation = -1;
	global.formation[formationId] = -1;
	send_buffer(BufferDataType.formationDestroy, array(formationId));
}

*/










// i guess we  could use this function when we need to update another global ds list in the future
// but we don't really need it right now
// also GML doesn't have pointers
// input: a string that represents a global variable
// output: the value variabble
function string_to_variable(str){

	// randomList
	// formation[5]
	// formation[2].tiles

	var cur = "", ref = pointer_null, sawDot = false;
	str = str + ".";
	
	for (var i=1; i<=string_length(str); i++){
		var c = string_char_at(str, i);
		
		//debug("charat", c, "ref", ref, sawDot)
		//debug(ref);
		//debug("checking...", ref);
		
		if (c == "[" || c == "."){
			//debug("checking...", c, ref);
			if (ref == pointer_null) ref = variable_global_get(cur);	
			//debug("checking..", c, ref);
			if (sawDot) ref = variable_struct_get(ref, cur); // assumption: '.' are always struct
			//debug("checking..",c, ref);
			cur = "";
			sawDot = (c == ".");
			//debug("checking...", ref);
		} else if (c == "]"){
			if (is_array(ref)) ref = ref[cur];
			else ref = ref[|cur]; // assumption: if its not an array its a ds_list
			cur = "";
		}
		
		else cur += c;
	}
	
	debug("returning ", ref)
	return ref;
}