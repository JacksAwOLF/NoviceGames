/// @description Insert description here
// You can write your code in this editor


// when cur reaches limit, 
// you can click on the hut and generate a soldier
limit = 5;
cur = 0;



// these variables are initialized when this is
// created in the obj_tile step event

// pos = 0;
// soldier_sprite = 0;


depth = -1;


def = []

def[Svars.attack_range] = global.soldier_vars[Svars.attack_range];
def[Svars.max_health] = global.soldier_vars[Svars.max_health];
def[Svars.max_damage] = global.soldier_vars[Svars.max_damage];
def[Svars.class] = global.soldier_vars[Svars.class];
def[Svars.vision] = global.soldier_vars[Svars.vision];
