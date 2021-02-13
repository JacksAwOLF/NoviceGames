/// @description Insert description here
// You can write your code in this editor



var text = "MAP CREATOR\n\n"
text += "Click on the images on the top row then on the grids to place tiles/soldiers down\n"
text += "Click on soldier to select it, press Space to deselect it\n"
text += "\n"
text += "Every turn, each soldier can attack once and move once in any order\n"
text += "Moving between flat and mountain/ocean costs 2, between ocean and mountain costs 3. All else costs 1\n"
text += "A soldier's attack is max(1, (health/max_health)*max_damage)\n"
text += "\n"
text += "To go to next turn, press Enter or click the Next button\n"
text += "Buttons on the top right are for modifying the soldier variables\n"
text += "\n"
text += "Save Map button only saves the tiles, not the soldiers. Remember the saved name to load it!\n"

draw_set_color(c_white)
draw_text_ext(room_width/10, room_height/10, text, -1, room_width/5*4);
draw_set_color(c_black)
