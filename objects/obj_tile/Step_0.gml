/// @description set mouseIn and chage sprite on click

mouseIn = x < mouse_x && mouse_x < x+size
	&& y < mouse_y && mouse_y < y+size;

draw_temp_soldier  = -1;




if (global.mouseInstanceId == id) {
	//debug("running event ", global.mouseEventId, " for instance ", instance_id, " of id ", id);

	if (global.mouseEventId == 0)  { // checking for double click
		if (enableDoubleClick && current_time - prevClickTime <= 300) {
			global.mouseEventId = 3;
			prevClickTime = -1;
		} else {
			prevClickTime = current_time;
		}
	}
	
	
	event_user(global.mouseEventId);
	
	global.mouseEventId = -1;
	global.mouseInstanceId = -1;
}



if mouseIn {	
	
	// draw temp army sprite if there is a selected 
	if (global.selectedSoldier != -1 && global.selectedSoldier.soldier.formation == -1) {
		
		// always maintain the last two tiles we hovered over
		if (global.prevHoveredTile != id) {
			global.prevHoveredTile = id;
		
			soldier_update_path(0);
		}
		
	}
	

}   // end of if (mouse_in)




preMouseIn = mouseIn;