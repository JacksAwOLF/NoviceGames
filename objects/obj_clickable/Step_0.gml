/// @description Insert description here
// You can write your code in this editor

if (global.mouseInstanceId == id) {
	debug("running event ", global.mouseEventId, " for instance ", instance_id, " of id ", id);
	event_user(global.mouseEventId);
	
	global.mouseEventId = -1;
	global.mouseInstanceId = -1;
}