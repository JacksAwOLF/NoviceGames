if global.loadMap 
	instance_create_depth(0,0,0,obj_loadMap_helper)
else 
	instance_create_depth(0,0,0,obj_createMap_helper)

global.turn = 0

