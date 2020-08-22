/// @function
function encode(value){
	value = real(value);
	return string(value);
}


/// @function
function decode(value){
	value = real(value);
	return real(value);
}