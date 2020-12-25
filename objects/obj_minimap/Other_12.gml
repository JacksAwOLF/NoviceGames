/// @description Move view by clicking on minimap


// if the click is inside the minimap
if (mouse_x-x > paddingX*image_xscale && mouse_x-x <= image_xscale*(minimapWidth+paddingX) && 
	mouse_y-y > paddingY*image_yscale && mouse_y-y <= image_yscale*(minimapHeight+paddingY)) {
			
	var mapMidpointX = ((mouse_x - x) / image_xscale - paddingX) / gridSizeX * tileSize + mapPaddingX;
	var mapMidpointY = ((mouse_y - y) / image_yscale - paddingY) / gridSizeY * tileSize + mapPaddingY;
	
	var newViewX = mapMidpointX - camera_get_view_width(global.main_camera) / 2;
	var newViewY = mapMidpointY - camera_get_view_height(global.main_camera) / 2;
	
	camera_set_view_pos(global.main_camera, newViewX, newViewY);
}