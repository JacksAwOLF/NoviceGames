// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function formationReset(){
	with (obj_infantry) formIndication = false;
	with(obj_confirmFormation) instance_destroy();
	with(obj_disbandFormation) instance_destroy();
	with(obj_nextFormation) instance_destroy();
}

global.formationStructures = []

function facingOut(oriSoldPos, checkSoldPos, fId, posInForm){
	var c = global.grid[checkSoldPos].soldier,
		o = global.grid[oriSoldPos].soldier,
		pat = global.formationStructures[fId].pattern,
		pw = array_length(pat[0]), pr =  floor(posInForm/pw), pc = posInForm % pw;
	
	if (c == -1) return false;
	if (c.team != o.team) return false;
	
	if (pr == 0) return c.direction == 0;
	else if (pr == 2) return c.direction == 180;
	else if (pc == 0) return c.direction == 90;
	else return c.direction == 270;
}
	

function facingSameDirection(oriSoldPos, checkSoldPos, fId, posInForm){
	var c = global.grid[checkSoldPos].soldier,
		o = global.grid[oriSoldPos].soldier;
	
	if (c == -1) return false;
	if (c.formation != -1) return false;
	if (c.team != o.team) return false;
	
	var same = o.direction == c.direction;
	
	if (fId != undefined){
		if  (fId == 0) same = same && (o.direction % 180 == 0);
		else if (fId == 1) same = same && (o.direction % 180 == 90);
	}
	return same;
}


// all formations


// 1=>must have soldier and apply to comparator
// 0=>must not have soldier
// 2=>doesn't matter
global.formationStructures = [{
	pattern: [[1,1,1]],
	comparator: facingSameDirection
},
{
	pattern: [[1],[1],[1]],
	comparator: facingSameDirection
},
{
	pattern: [[2,1,2],
			  [1,0,1],
			  [2,1,2]],
	comparator: facingOut
}];



// returns a list of possible formation structures that 
// the soldier at posSoldier is a part of

// a possible formation is a struct like
// 

function possibleFormationStruct(_fid, _sold) constructor {
	formationId = _fid;
	soldiers = _sold
}



function partOfNewFormation(posSoldier){
	
	var res = -1;
	
	for (var i=0; i<array_length(global.formationStructures); i++){
		
		var str = global.formationStructures[i],
			row = floor(posSoldier/global.mapWidth),
			col = posSoldier%global.mapWidth;
		
		// check if this formation is valid while including posSoldier
		var ph = array_length(str.pattern), pw = array_length(str.pattern[0]);
		
		
		for (var a=0; a<ph; a++)
		for (var b=0; b<pw; b++){ 
			
			if (row - a < 0 || col - b < 0 ) continue;
			if (row-a+ph >= global.mapHeight || col-b+pw >= global.mapWidth) continue;
			
			// this position needs to be a 1 (because posSolddier definitely haas a soldier)
			if (str.pattern[a][b] != 1) continue;
			
			// if posSoldier was pattern[a][b], check if other positions match up
			var matched = true, sr = row-a, sc = col-b, solds = []; 
			for (var a2=0; a2<ph && matched; a2++)
			for (var b2=0; b2<pw && matched; b2++){  
				var posToCheck = (sr+a2)*global.mapWidth + (sc+b2);
				var pat = str.pattern[a2][b2];
				var osold = global.grid[posToCheck].soldier;
				
				// for pat = 0, 1: check if there is soldier corresponding to  that
				if (pat!=2 && pat != (osold != -1) ) matched = false;
				
				// if soldier existence matches, load the comparator
				else if (pat==1 && (osold.formation !=-1 ||
					!str.comparator(posSoldier, posToCheck, i, a2*pw+b2))) matched = false;
				
				// add to the soldier array			
				if (matched && str.pattern[a2][b2]==1) solds = append(solds, global.grid[posToCheck].soldier)
			}
			
			if (matched){
				if (res == -1) res = [];
				res = append(res, new possibleFormationStruct(i, solds) );
			}
		}
	}
	
	return res;
}


/*
function partOfExistingFormation(soldierId){
	for (var i=0; i<array_length(global.formation[soldierId.team].soldiers); i++)
		if (posInArray(global.formation[soldierId.team].soldiers, soldierId) != -1)
			return i;
	return -1;
}*/