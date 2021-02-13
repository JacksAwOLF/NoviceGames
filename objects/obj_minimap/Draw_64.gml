/// @description Insert description here
// You can write your code in this editor


if (state == VisualState.inactive) exit;

var wdth = minimapWidth * camera_get_view_width(global.main_camera) / (global.mapWidth * tileSize);
var hght = minimapHeight * camera_get_view_height(global.main_camera) / (global.mapHeight * tileSize);

var viewx = minimapWidth * (camera_get_view_x(global.main_camera) - mapPaddingX) / (global.mapWidth * tileSize);
var viewy = minimapHeight * (camera_get_view_y(global.main_camera) - mapPaddingY) / (global.mapHeight * tileSize);

var topLeftX = global.minimap_params.start_x + paddingX + max(0, viewx);
var topLeftY = global.minimap_params.start_y + paddingY + max(0, viewy);

var botRightX = global.minimap_params.start_x + paddingX + min(minimapWidth, viewx+wdth);
var botRightY = global.minimap_params.start_y + paddingY + min(minimapHeight, viewy+hght);


if (viewy >= 0)
	draw_line_color(topLeftX, topLeftY, botRightX, topLeftY, c_black, c_black);
if (viewx >= 0)
	draw_line_color(topLeftX, topLeftY, topLeftX, botRightY, c_black, c_black);
if (viewx+wdth < minimapWidth)
	draw_line_color(botRightX, topLeftY, botRightX, botRightY, c_black, c_black);
if (viewy+hght < minimapHeight)
	draw_line_color(topLeftX, botRightY, botRightX, botRightY, c_black, c_black);
