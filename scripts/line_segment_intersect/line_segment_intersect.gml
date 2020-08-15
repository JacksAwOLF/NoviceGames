// returns whether segment(argument[0], argument[1]) to (argument[2], argument[3]) intersects
// (argument[4], argument[5]) to (argument[6], argument[7])


var f1 = ccw(argument[0],argument[1],argument[2],argument[3],argument[4],argument[5]);
var f2 = ccw(argument[0],argument[1],argument[2],argument[3],argument[6],argument[7]);

var s1 = ccw(argument[4],argument[5],argument[6],argument[7],argument[0],argument[1]);
var s2 = ccw(argument[4],argument[5],argument[6],argument[7],argument[2],argument[3]);

return f1 * f2 < 0 && s1 * s2 < 0;