/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

minimapWidth = 150;
minimapHeight = 150;

gridSizeX = minimapWidth / global.mapWidth;
gridSizeY = minimapHeight / global.mapHeight;

paddingX = 10;
paddingY = 10;

hide_key = ord("P");


// initialize in init_map
tileSize = -1;
mapPaddingX = -1;
mapPaddingY = -1;


// make global copy of params (read only)
global.minimap_params = 
	{
		active: true,
		start_x: x,
		start_y: y,
		
		padding_x: paddingX,
		padding_y: paddingY,
		
		grid_size_x: gridSizeX,
		grid_size_y: gridSizeY,
		
		map_width: minimapWidth,
		map_height: minimapHeight,
	
	};
