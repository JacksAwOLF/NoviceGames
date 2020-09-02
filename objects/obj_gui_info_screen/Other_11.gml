/// @description mouse left still down


// difference between current mouse position & previous
var diffx = (mouse_x - mouse_xstart) / camera_get_view_width(current_camera);
var diffy = (mouse_y - mouse_ystart) / camera_get_view_height(current_camera);

// only begin moving when difference is big enough
if (abs(diffx) > 0.01 || abs(diffy) > 0.01) 
	is_moving = true;

if (is_moving) {
	relx += diffx;
	rely += diffy;

	mouse_xstart = mouse_x;
	mouse_ystart = mouse_y;
}
