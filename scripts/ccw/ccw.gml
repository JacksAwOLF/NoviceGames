// returns (B-A) X (C-A)

// A: argument[0], [1]
// B: argument[2], [3]
// C: argument[4], [5]

var BAx = argument[2]-argument[0];
var BAy = argument[3]-argument[1];

var CAx = argument[4]-argument[0];
var CAy = argument[5]-argument[1];


// if result < 0, then C lies on left side of A-B
// if result > 0, then C lies on right side of A-B
// if result == 0, then C lies on parallel line of A-B

return BAx*CAy - BAy*CAx;