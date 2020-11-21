// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function switch_to_bomber() {
	if (global.selectedSoldier.soldier.unit_id != Units.CARRIER)
		show_error("Switch to bomber called when seaplane carrier isn't selected", true);
	global.selectedSoldier.soldier.selectedPlaneId = Units.BOMBER;
	global.selectedSoldier.soldier.can = 0;
	
	event_perform_object(obj_map_helper, ev_keypress, vk_space);
}

function switch_to_recon() {
	if (global.selectedSoldier.soldier.unit_id != Units.CARRIER)
		show_error("Switch to recon called when seaplane carrier isn't selected", true);
	global.selectedSoldier.soldier.selectedPlaneId = Units.RECON;
	global.selectedSoldier.soldier.can = 0;
	
	event_perform_object(obj_map_helper, ev_keypress, vk_space);
}

function switch_to_fighter() {
	if (global.selectedSoldier.soldier.unit_id != Units.CARRIER)
		show_error("Switch to fighter called when seaplane carrier isn't selected", true);
	global.selectedSoldier.soldier.selectedPlaneId = Units.FIGHTER;
	global.selectedSoldier.soldier.can = 0;
	
	event_perform_object(obj_map_helper, ev_keypress, vk_space);
}

function deploy_plane() {
	if (global.selectedSoldier.soldier.unit_id != Units.CARRIER)
		show_error("Deploy plane called when seaplane carrier isn't selected", true);
		
	global.selectedSoldier.soldier.can = 0;
	event_perform_object(obj_map_helper, ev_keypress, vk_space);
}