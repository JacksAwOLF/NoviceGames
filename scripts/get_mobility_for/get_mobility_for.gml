// returns [movement, energy array] given a sprite index;

return 0;
var movement, energy;
		
switch argument[0] {

	case spr_infantry: 
	case spr_infantry1:
		movement = 2;
		energy = array(1, 1, 2, 2);
		break;
			
	case spr_tanks:
	case spr_tanks1:
		movement = 6;
		energy = array(2,3,3,99);
		break;
				
	case spr_ifvs:
	case spr_ifvs1:
		movement = 15;
		energy = array(3,5,99,99);
		break;
		
	default:
		movement = move_range;
		energy = array(1, 1, 2, 3);
}
		
		
return [movement, energy];