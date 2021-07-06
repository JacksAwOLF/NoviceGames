// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function dia_rm_sideMap(){
	global.textGraph = array_create(7);
	
	
	global.textGraph[1] = 
		new TextNode("flag-chan", spr_flag, 0, 
			[{
				text: 
					"oh so you have interacted on this flag! "
					+ "You wonder what would happen if you "
					+"were to press the enter key",
			}],
			[],
			[new TextEdge(2, -1)]
		);
			
	global.textGraph[2] = 
		new TextNode("flag-chan", spr_flag, 0,
			[{
				text:
					"A man shows up and greets you. " 
					+"He reminds you that you can choose with movement keys A and D, "
					+"and commit your choice with enter. "
					+"Hi there! he says",
			}],
			[
				
				new DialogueOption("good bye", [new TextEdge(-1, -1)], -1),
				new DialogueOption("hello", [new TextEdge(3, -1)], -1)
			],
			-1
		);
	
	global.textGraph[3] = 
		(new TextNode("flag-chan", spr_flag, 0,
			[{
				text:
					"why hello there miss                           \n"
					+"if im talking too slow feel free to press space..."
					+" hih ihi ihi hih iihi hih ihih ii hihi hih ihi hih i "
					+"btw who tf are you? do you want to die?!!??!"
			}],
			[
				new DialogueOption("yes please", [new TextEdge(4, -1)], -1),
				new DialogueOption("ummm no", [new TextEdge(5, -1)], -1),
				new DialogueOption("wtf", [new TextEdge(6, -1)], -1)
			],
			-1
		)).setEnter(function() {audio_play_sound(snd_ayame, 1, false);});
	
	global.textGraph[4] = 
		new TextNode("flag-chan", spr_flag, 0, [{text:"oh same!"}], -1, -1);
	global.textGraph[5] = 
		new TextNode("flag-chan", spr_flag, 0, [{text:"wait what"}], -1, -1);
	global.textGraph[6] =
		new TextNode("flag-chan", spr_flag, 0, 
			[{text:"sorry I don't understand Chinese"}],
			[new DialogueOption("that's not chinese bro", [new TextEdge(-1, -1)], -1)],
			-1
		);
			
	
}