current_camera = view_get_camera(0);

//These following two values establish the default view scale as a reference point
window_max_w = camera_get_view_width(current_camera);
window_max_h = camera_get_view_height(current_camera);

//the rate of which the camera zooms in and out. Adjust this to your liking, lower numbers are faster
zoom_speed = 50;
should_follow_turn = -1; // checks (should_follow_turn == this turn) to follow a soldier