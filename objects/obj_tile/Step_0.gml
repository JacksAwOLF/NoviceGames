/// @description set mouseIn and chage sprite on click

mouseIn = x < mouse_x && mouse_x < x+sprite_width
	&& y < mouse_y && mouse_y < y+sprite_height;

if mouseIn {

	if (global.selectedSoldier != -1 && global.selectedSoldier.formation == -1) {

		// always maintain the last two tiles we hovered over
		if (global.prevHoveredTile != id) {
			global.prevHoveredTile = id
			debug("{obj tile step event enter")
			soldier_update_path(false);
			debug("{obj tile step event leave")
		}
	}
}

event_inherited();
preMouseIn = mouseIn;
