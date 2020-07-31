/// @description set mouseIn and chage sprite on click

mouseIn = x <= mouse_x && mouse_x <= x+size
	&& y <= mouse_y && mouse_y <= y+size;

draw_temp_soldier  = -1;



if mouseIn {
	
	
	// if mouse in and left is pressed down, we change the tiles if neccessary
	if (mouse_check_button(mb_left) && global.changeSprite[0] != -1)
		sprite_index = global.changeSprite[0];
	
	
	// draw temp army sprite if there is a selected 
	if (global.selectedSoldier != -1 && possible_move){
		draw_temp_soldier = global.selectedSoldier.soldier.sprite_index;
		soldier_init_attack();
	}
	
	
	
	if (mouse_check_button_pressed(mb_left)){
	
debug("Mouse clicked in tile ", pos, " with changeSprite: ", global.changeSprite[0], global.changeSprite[1], "and selectedSoldier:",global.selectedSoldier);	
	
	
	
		// if we clicked on a selection tile before, change the sprite tile
		//if (global.changeSprite[0] != -1) sprite_index = global.changeSprite[0];			
		
		// if we clicked on a selection soldier before, add a soldier if there's not a soldier on this tile
		if (global.changeSprite[1] != -1){
			
			// if there's a soldier here,  activate the next block of if statement
			if  (soldier != -1) global.changeSprite[1] = -1; 
			else {
				var cs = global.changeSprite[1];
				if (cs == spr_infantry || cs == spr_infantry1) 
					soldier = instance_create_depth(x,y,0,obj_infantry);
				// else if (cs == spr_archer || cs == spr_archer1)
				
				// becomes enemey if the sprite naem ends with 1
				soldier.sprite_index = cs;
				with(soldier) update_team();
				
			}
		}
	
		// this block handles other clicking events like moving and attacking
		else if (global.changeSprite[0] == -1){		
		
			// clear the selected soldier things if this block is not a possible move or attack
			if (global.selectedSoldier != -1){
				
				var xx = x;
				var yy  = y;
				
				if (possible_move && id != global.selectedSoldier){						// if this tile is a possible move (not itself)
					
					with (global.selectedSoldier){	
						with(soldier){			  // move the soldier
							
							//debug("from ", x, y);
							
							x = xx;
							y = yy;
							can_move = false;
						}
						other.soldier = soldier;											// change the  soldier acces
						soldier =  -1;
					}
					
					global.selectedSoldier = id;											// change the global tile access
					soldier_erase_move();
					
					
					if (!soldier_init_attack()){
						global.selectedSoldier = -1;
						exit;
					}
					
					
				}
				
				
				
				else if (possible_attack){
					
					with(global.selectedSoldier.soldier){
						var damage_inflicted = (my_health/max_health) * max_damage;
						other.soldier.my_health -= damage_inflicted;
						can_attack = false;
					}
						
					if (soldier.my_health <= 0){
						instance_destroy(soldier);
						soldier = -1;
					}
					
					soldier_erase_attack();
					soldier_init_move();
				}
				
				
				else{
					soldier_erase_attack();
					soldier_erase_move();
					
					global.selectedSoldier = (id == global.selectedSoldier ? -2 : -1);
				}
				
				
			}
			
			
		
			
			if (global.selectedSoldier == -1){										// if not assigned selected soldier yet
				//debug("selecting  this  soldier", soldier.team, global.turn, global.turn%2)
				if (soldier != -1 && soldier.team == (global.turn)%2){					// if there is a soldier on this tile
					
					if (soldier.can_move){													// if the soldier can move
						global.selectedSoldier = id;											// draw on the moving tiles
						soldier_init_move();			
					}
					
					
					if (soldier.can_attack){												// if soldier can attack	
						global.selectedSoldier = id;											// daw on the  attack tiles
						soldier_init_attack();
					}
				}
			} 
			
			if (global.selectedSoldier == -2) global.selectedSoldier = -1;
			
			

			// if soldier is selected, but it can't  attack or move, deselect  it
			if (global.selectedSoldier != -1) with(global.selectedSoldier.soldier){
				if (!can_attack and !can_move)
					global.selectedSoldier = -1;
			}
			
			
		} // end of if global.changeSprites[0] = [1] = -1
		
		
	} // end of if (mouse_check_button_pressed)
	
	
	
}   // end of if (mouse_in)

