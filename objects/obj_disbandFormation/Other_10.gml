/// @description Insert description here
// You can write your code in this editor





var formId = global.selectedFormation;

if (formId != -1) {
	var arr = global.formation[formId].tiles;
	for (var i =0; i<array_length(arr); i++){
		if (arr[i].soldier == -1)
			continue;
		arr[i].soldier.formation = -1;
	}


	// replace this with a ds_list in the future
	global.formation[formId] = -1;

	event_perform_object(obj_map_helper, ev_keypress, vk_space);
	formationReset();
}