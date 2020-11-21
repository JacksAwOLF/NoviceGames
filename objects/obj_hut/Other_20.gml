/// @description load variables for soldier
// You can write your code in this editor


// load the generate variables
// set soldier first  before  calling this
// soldier is which soldier this hut should generate
steps = 0;


soldier_unit = soldier.unit_id;
soldier_sprite = soldier.sprite_index;
team = get_team(soldier_sprite);

limit = global.hutlimit[soldier_unit];

max_health = 10;
my_health = max_health;


