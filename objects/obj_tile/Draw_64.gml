/// @description Drawing to minimap

if (global.minimap_params.active) {
	
	var paddingX = global.minimap_params.padding_x;
	var paddingY = global.minimap_params.padding_y;
	
	// horizontal and vertical scale
	var sizeX = global.minimap_params.grid_size_x;
	var sizeY = global.minimap_params.grid_size_y;
	
	// calculate location on minimap to draw to
	var minimapX = global.minimap_params.start_x + paddingX + sizeX * (pos % global.mapWidth);
	var minimapY = global.minimap_params.start_y + paddingY + sizeY * floor(pos / global.mapWidth);
	
	var inRain = false;

	if (global.weather == Weather.RAINY) {
		var rowDiff = getRowDiff(pos, global.rain_center_pos);
		var colDiff = getColDiff(pos, global.rain_center_pos);
	
		inRain = (rowDiff*rowDiff + colDiff*colDiff <= global.rain_radius_squared);
	}
	
	draw_sprite_stretched_ext(sprite_index, 0, minimapX, minimapY, sizeX, sizeY, (inRain ? c_teal : c_white), (hide_soldier ? 0.5 : 1));
}