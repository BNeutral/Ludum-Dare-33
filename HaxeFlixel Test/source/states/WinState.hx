package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class WinState extends FlxState
{
	private var timeCounter : Float = 0;

	override public function create():Void 
	{
		super.create();
		bgColor = 0xFFFFFF;
		
		FlxG.sound.playMusic("assets/music/Compressed/Game Win.mp3");
		
		add(new FlxSprite(0, 0, "assets/images/menUI/winFog.png"));
		add(new FlxSprite(0, 0, "assets/images/menUI/winBase.png"));
		add(new FlxSprite(0, 0, "assets/images/menUI/winTreasure.png"));
		add(new FlxSprite(0, 0, "assets/images/menUI/winChest.png"));
		add(new FlxSprite(0, 0, "assets/images/menUI/winGround.png"));
		add(new FlxSprite(0, 0, "assets/images/menUI/winSlimes.png"));		
		
		var text1: FlxText = new FlxText(0, -30, FlxG.width, "YOU WIN!", 42, true);
		text1.font = "assets/fonts/DJB Speak Softly.ttf";
		FlxTween.tween(text1, { y : 300 }, 2, { ease : FlxEase.bounceOut } );
		text1.color = 0x000000;
		text1.alignment = "center";
		add(text1);
		var text : FlxText = new FlxText(0, -30, FlxG.width, "Thank you for playing.", 42, true);
		text.font = "assets/fonts/DJB Speak Softly.ttf";
		FlxTween.tween(text, { y : 500 }, 2, { ease : FlxEase.bounceOut } );
		text.color = 0x000000;
		text.alignment = "center";
		add(text);
	}
	
	override public function update():Void 
	{
		super.update();
		timeCounter += FlxG.elapsed;
		if (timeCounter > 5 && FlxG.keys.justPressed.ANY) FlxG.switchState(new MenuState());
	}
	
}