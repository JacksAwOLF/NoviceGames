/// @description Insert description here
// You can write your code in this editor

text = 
	(new TextNode(
	"oh so you have interacted on this flag! "
	+ "You wonder what would happen if you "
	+"were to press the enter key"))
	.setNext(

		(new TextNode(
		"A man shows up and greets you. " 
		+"He reminds you that you can choose with movement keys A and D, "
		+"and commit your choice with enter. "
		+"Hi there! he says"))
	
		.addOption(
			["good bye", "hello"], 
			[undefined, 
				(new TextNode(
				"why hello there miss                           \n"
				+"if im talking too slow feel free to press space..."
				+" hih ihi ihi hih iihi hih ihih ii hihi hih ihi hih i "
				+"btw who tf are you? do you want to die?!!??!", 
				["yes please", "ummm no", "wtf"]))
				
				.updateOption("ummm no", (new TextNode("oh same!")))
				.updateOption("yes please", (new TextNode("wait what")))
				.updateOption("wtf", 
					(new TextNode("sorry I don't understand chinese"))
					.addOption("that's not chinese bro")
				)
				
				.setSpd(0.5)
				
				.setEnter(function(){audio_play_sound(snd_ayame, 1, false);})
			]
		)
	);



interact = function() 
{
	textBox(text, DialogueTypes.OptionRow);
}
