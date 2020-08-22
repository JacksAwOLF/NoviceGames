/// @description Insert description here
// You can write your code in this editor

event_inherited();

hide_key = ord("E");
relx = x / camera_get_view_width(0);
rely = y / camera_get_view_height(0);

origw = camera_get_view_width(0);
origh = camera_get_view_height(0);


enum VisualState
{
	active,
	deactivating,
	inactive,
	activating
}

state = VisualState.active;
inactive_offset = [4*room_width, 0];




//depth =  -100