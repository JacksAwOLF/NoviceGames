
interact = function() 
{
	textBox(
		new TextNode(
			"White Flag", 
			spr_bomber, 
			0, 
			[{text: "Come back after you have met sad chan."}], 
			[
				new DialogueOption("wha- who?", -1, function(){return global.bitch == 0}),
				new DialogueOption("yee i did", -1, function(){return global.bitch != 0})
			],
			-1
		).setLeave(function(){
			if (global.bitch != 0){
				with(instance_create_depth(x, y, 0, obj_door)){
					debug("door created")
					toTransition = rm_platform;
				}
				instance_destroy();
			}
		}), 
		DialogueTypes.OptionRow
	);
}