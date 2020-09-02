/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event

if (state == VisualState.inactive) exit;

draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,0,c_white,0.7);

if (global.displayTileInfo != -1) {
	
	var cur = global.displayTileInfo.soldier;
	var text = [], len = 0;
	
	if (cur != -1 && cur.team != global.turn % 2 && global.displayTileInfo.hide_soldier)
		cur = -1;
		
	text[len++] = "Soldier Info: " + (cur == -1 ? " N/A" : "");
	text[len++] = "  Unit Class: " + (cur == -1 ? " N/A" : global.classNames[cur.class]);
	text[len++] = "    Vision Energy: " + (cur == -1 ? " N/A" : string(cur.vision));
	text[len++] = "  Unit Type: " + (cur == -1 ? " N/A" : global.unitNames[get_soldier_type(cur)]);
	text[len++] = "    Type Movement: " + (cur == -1 ? " N/A" : string(global.movement[get_soldier_type(cur)]));
	text[len++] = "  Attack Range: " + (cur == -1 ? " N/A" : string(cur.attack_range));
	text[len++] = "  Max Damage: " + (cur == -1 ? " N/A" : string(cur.max_damage));
	text[len++] = "  Health: " + (cur == -1 ? " N/A" : string(cur.my_health));
	
	text[len++] = ""
	text[len++] = "Tile Info: ";
	text[len++] = "  Tile Type: " + global.tileNames[get_tile_type(global.displayTileInfo)];
	text[len++] = "  Elevation: " + string(global.displayTileInfo.elevation);
	
	for (var i = 0; i < len; i++) {
		var xx = x+10*image_xscale;
		var yy = y+10*image_yscale+i*20*image_yscale
		draw_text_transformed(xx,yy,text[i],image_xscale,image_yscale,0);
	}
	
}
