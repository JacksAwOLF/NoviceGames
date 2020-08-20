function get_soldier_type() {
	// returns index in global.energy for a given soldier instance (arg0)

	//debug(argument[0]);

	switch(argument[0].sprite_index) {
		case spr_infantry: 
		case spr_infantry1:
			return Soldiers.infantry;
			
		case spr_tanks:
		case spr_tanks1:
			return Soldiers.tanks;
				
		case spr_ifvs:
		case spr_ifvs1:
			return Soldiers.ifvs;
		
		default:
			return -1;
	}


}
