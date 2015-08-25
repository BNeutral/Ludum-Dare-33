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

	public function new() 
	{
		super();
		bgColor = 0xFFFFFF;
		
		FlxG.sound.playMusic("assets/music/Game Win.mp3");
		
		add(new FlxSprite(0, 0, "assets/images/menUI/winFog.png"));
		add(new FlxSprite(0, 0, "assets/images/menUI/winBase.png"));
		add(new FlxSprite(0, 0, "assets/images/menUI/winTreasure.png"));
		add(new FlxSprite(0, 0, "assets/images/menUI/winChest.png"));
		add(new FlxSprite(0, 0, "assets/images/menUI/winGround.png"));
		add(new FlxSprite(0, 0, "assets/images/menUI/winSlimes.png"));		
		
		var text: FlxText = new FlxText(0, -30, FlxG.width, "YOU WIN!", 42, true);
		text.font = "assets/fonts/DJB Speak Softly.ttf";
		FlxTween.tween(text, { y : 100 }, 1, { ease : FlxEase.bounceOut } );
		text.color = 0x000000;
		add(text);
		text = new FlxText(0, -30, FlxG.width, "Thank you for playing.", 42, true);
		text.font = "assets/fonts/DJB Speak Softly.ttf";
		FlxTween.tween(text, { y : 500 }, 1, { ease : FlxEase.bounceOut } );
		text.color = 0x000000;
		add(text);
	}
	
	override public function update():Void 
	{
		super.update();
		timeCounter += FlxG.elapsed;
		if (timeCounter > 5 && FlxG.keys.justPressed.ANY) FlxG.switchState(new MenuState());
	}
	
}