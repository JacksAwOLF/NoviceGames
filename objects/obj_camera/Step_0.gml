

#region panning
#macro width_offset 100
#macro height_offset 100


//when the mouse button is pressed, it captures the values of the mouse's X and Y position.
//Because the view is going to be moved, we want the position of the mouse in relation to
// the window, not the view.
if mouse_check_button_pressed(mb_right)
{
	mouse_xstart = mouse_x;
	mouse_ystart = mouse_y;
}

//establish values of the view's current scale for reference
var prev_view_w = camera_get_view_width(current_camera);//view_wview;
var prev_view_h = camera_get_view_height(current_camera);

var changed = false;
var newx, newy, neww = prev_view_w, newh = prev_view_h;

//so long as the mouse button is held down, the X and Y coordinate of the view will change to
// be the difference between the mouse's current position and the position it was when we started.
if mouse_check_button(mb_right)
{
	
	newx = camera_get_view_x(current_camera) + mouse_xstart - mouse_x;
	newy = camera_get_view_y(current_camera) + mouse_ystart - mouse_y;
	
	changed = true;
}

//zooming
if mouse_wheel_up()
{
	//increase the view scale based on our zoom_speed variable. Dividing the value based on
	//the original X and Y scales of the view ensure that the aspect ratio remains consistent.
	neww = prev_view_w - room_width/zoom_speed;
	newh = prev_view_h - room_height/zoom_speed;

	//we now want the view to zoom in towards the center of the view as opposed to the top
	//left corner as it would natural want to do.
	newx = camera_get_view_x(current_camera) + abs(neww-prev_view_w)/2;
	newy = camera_get_view_y(current_camera) + abs(newh-prev_view_h)/2;
	
	changed = true;
}

//and just repeat the same code for zooming out only reverse the math.
if mouse_wheel_down()
{
	//increase the view scale based on our zoom_speed variable. Dividing the value based on
	//the original X and Y scales of the view ensure that the aspect ratio remains consistent.
	neww = prev_view_w + room_width/zoom_speed;
	newh = prev_view_h + room_height/zoom_speed;

	//we now want the view to zoom in towards the center of the view as opposed to the top
	//left corner as it would natural want to do.
	newx = camera_get_view_x(current_camera) - abs(neww-prev_view_w)/2;
	newy = camera_get_view_y(current_camera) - abs(newh-prev_view_h)/2;
	
	changed = true;
}

if (changed && (newx+neww >= width_offset && newx <= window_max_w-width_offset) &&
				(newy+newh >= height_offset && newy <= window_max_h-height_offset) &&
	point_in_rectangle(neww, newh, window_max_w/global.mapWidth, window_max_h/global.mapHeight,
					   2*window_max_w, 2*window_max_h)) {
	
	global.shouldFocusTurn = -1;
	camera_set_view_pos(current_camera, newx, newy);
	camera_set_view_size(current_camera, neww, newh);
	
} else {
	mouse_xstart = mouse_x;
	mouse_ystart = mouse_y;
}

#endregion panning





#region following

if (global.map_loaded && global.shouldFocusTurn == global.turn) {
	// camera processing
	var visible_team = global.edit ? global.turn % 2 : global.playas;
	var toFollow = ds_list_find_value(global.allSoldiers[visible_team], global.followSoldier).tileInst;
		
	var newx = toFollow.x + toFollow.size/2 - camera_get_view_width(current_camera)/2;
	var newy = toFollow.y + toFollow.size/2 - camera_get_view_height(current_camera)/2;
	camera_set_view_pos(current_camera, newx, newy);
}

#endregion following
