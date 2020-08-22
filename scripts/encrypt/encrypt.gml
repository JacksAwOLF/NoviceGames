/// @function  encoding an  integer (or multiple arguments) to a string
function encode(){
	var value = "";
	for (var i=0; i<argument_count; i++){
		var t = real(argument[i]);
		value += string(t) + " "
	}
	return value;
}


/// @function decoding the string into an integer
function decode(value){
	value = real(value);
	return real(value);
}



function get_state(){
	
	var state = "";
	
	// encode position, health, direction, team for each soldier
	for (var i=0; i<global.mapWidth * global.mapHeight; i++)
		with(global.grid[i])
			if (soldier != -1) 
				state  += encode(pos, soldier.my_health, 
				soldier.max_health, soldier.direction,  soldier.team) + "\n";
	
	return state;
}


function set_state(state){
	
	
	
}
				