/// @description Updating options with options_id
// You can write your code in this editor


if (options_id >= 0 && options_id < array_length(options)) {
	binded_button.sprite_index = options[options_id];
	update_change_sprite(options[options_id]);
	dropdown_active = !dropdown_active;
}
