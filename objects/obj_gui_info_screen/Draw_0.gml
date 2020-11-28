/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event

if (state == VisualState.inactive) exit;

draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,0,c_white,0.7);

	
var curSoldier = (global.displayTileInfo != -1 ? global.displayTileInfo.soldier : -1);
var curHut = (global.displayTileInfo != -1 ? global.displayTileInfo.hut : -1);
var text = [], len = 0;

if (curSoldier != -1 && curSoldier.team != global.turn % 2 && global.displayTileInfo.hide_soldier)
	curSoldier = -1;
if (curHut != -1 && curHut.team != global.turn % 2 && global.displayTileInfo.hide_soldier)
	curHut = -1;
		
		

text[len++] = "Tile Info: " + (global.displayTileInfo == -1 ? "N/A" : "");
text[len++] = "  Tile Type: " + (global.displayTileInfo == -1 ? "N/A" : global.tileNames[get_tile_type(global.displayTileInfo)]);
text[len++] = "  Elevation: " + (global.displayTileInfo == -1 ? "N/A" : string(global.displayTileInfo.elevation));

text[len++] = "";
text[len++] = "Soldier Info: " + (curSoldier == -1 ? " N/A" : "");
text[len++] = "  Unit ID: " + (curSoldier == -1 ? " N/A" : global.unitNames[curSoldier.unit_id]);
text[len++] = "    Vision Energy: " + (curSoldier == -1 ? " N/A" : string(curSoldier.vision));
text[len++] = "    Type Movement: " + (curSoldier == -1 ? " N/A" : string(global.movement[curSoldier.unit_id]));
text[len++] = "  Attack Range: " + (curSoldier == -1 ? " N/A" : string(curSoldier.attack_range));
text[len++] = "  Max Damage: " + (curSoldier == -1 ? " N/A" : string(curSoldier.max_damage));
text[len++] = "  Health: " + (curSoldier == -1 ? " N/A" : string(curSoldier.my_health));

text[len++] = "";
text[len++] = "Hut Info: " + (curHut == -1 ? "N/A" : "");
text[len++] = "  Unit Type: " + (curHut == -1 || curHut.soldier_sprite == -1 ? "N/A" : global.unitNames[curHut.soldier_unit]);
text[len++] = "  Turns: " + (curHut == -1 || curHut.steps == -1 ? "N/A" : string(curHut.steps) + "/" + string(curHut.limit));
text[len++] = "  Health: " + (curHut == -1 ? "N/A" : string(curHut.my_health));


for (var i = 0; i < len; i++) {
	var xx = x+10*image_xscale;
	var yy = y+10*image_yscale+i*20*image_yscale;
	draw_text_transformed(xx,yy,text[i],image_xscale,image_yscale,0);
}