package states ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import buttons.TextWithCallback;
import flixel.util.FlxSpriteUtil;
import openfl.display.BitmapData;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	private var texts : Array<TextWithCallback> = new Array<TextWithCallback>();
	private var cursor : FlxSprite = new FlxSprite(500, 0, "assets/images/slimeIcon.png");
	private var cursorCounter : Int = 0;
	
	private var logo : FlxSprite = new FlxSprite(22, 15, "assets/images/menUI/menuLogo.png");
	
	private var but1 : FlxSprite = new FlxSprite(570, 15, "assets/images/menUI/button1.png");
	private var but2 : FlxSprite = new FlxSprite(550, 100, "assets/images/menUI/button2.png");
	private var but3 : FlxSprite = new FlxSprite(570, 175, "assets/images/menUI/button3.png");
	
	private var menuBack : FlxSprite = new FlxSprite(0, 0, "assets/images/menUI/menuBackdrop.png");
	private var menuGround : FlxSprite = new FlxSprite(0, 430, "assets/images/menUI/menuGround.png");
	private var menuChest : FlxSprite = new FlxSprite(395, 265, "assets/images/menUI/menuChest.png");
	private var menuSlimes : FlxSprite = new FlxSprite(310, 440, "assets/images/menUI/menuSlimes.png");
	
	
	private var winBack : FlxSprite = new FlxSprite(0, 0, "assets/images/menUI/winFog.png");
	private var winBackSlimegirl : FlxSprite = new FlxSprite(0, 0, "assets/images/menUI/winBase.png");
	private var winBackTreasure : FlxSprite = new FlxSprite(0, 0, "assets/images/menUI/winTreasure.png");
	private var winChest : FlxSprite = new FlxSprite(0, 0, "assets/images/menUI/winChest.png");
	private var winGround : FlxSprite = new FlxSprite(0, 0, "assets/images/menUI/winGround.png");
	private var winSlimes : FlxSprite = new FlxSprite(0, 0, "assets/images/menUI/winSlimes.png");

	
	
	private static inline var yOffset : Int = 50;
	private static inline var ySpacing : Int = 80;
	
	
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		addOption("", function() { FlxG.switchState(new PlayState()); } );
		addOption("", function(){ FlxG.switchState(new LevelSelectState()); } );
		//addOption("CONTROLS", function(){ FlxG.switchState(new ControlsState()); } );
		addOption("", function() { FlxG.switchState(new CreditsState()); } );
		
		this.bgColor = 0xFFCBF1E4;
		FlxG.sound.playMusic("assets/music/Compressed/Menu Theme.mp3");
		
		if (Reg.wonTheGame == false)
		{
			add(menuBack);
			add(menuGround);
			add(menuChest);
			add(menuSlimes);
		}
		
		if (Reg.wonTheGame == true)
		{
			add(winBack);
			add(winBackSlimegirl);
			add(winBackTreasure);
			add(winChest);
			add(winGround);
			add(winSlimes);
		}
		
		add(logo);	
		add(but1);
		add(but2);
		add(but3);
		

		
		updateCursorPos();
		add(cursor);
		
		var txt : FlxText = new FlxText(0, FlxG.height - 36, FlxG.width, "A game made in 72 hours for Ludum Dare 33", 24);
		txt.alignment = "center";
		add(txt);
		
		FlxTween.tween(cursor, { angle : 360 }, 1.5, {type : FlxTween.LOOPING, ease : FlxEase.cubeInOut});
		
		FlxG.mouse.visible = false;
	}
	
	private function addOption(text : String, callback : Void->Void) : Void
	{
		var text : TextWithCallback = new TextWithCallback(callback, 0, yOffset + ySpacing * texts.length, FlxG.width, text, 32);
		text.alignment = "center";
		add(text);
		texts.push(text);
	}
	
	override public function update():Void 
	{
		super.update();
		if (FlxG.keys.justPressed.UP)
		{
			--cursorCounter;
			updateCursorPos();
			FlxG.sound.play("assets/sounds/MenuSelect.mp3");
		}
		if (FlxG.keys.justPressed.DOWN)
		{
			++cursorCounter;
			updateCursorPos();
			FlxG.sound.play("assets/sounds/MenuSelect.mp3");
		}
		if (FlxG.keys.justPressed.ENTER) 
		{
			FlxG.sound.play("assets/sounds/100%.mp3");
			texts[cursorCounter].callback();
		}
	}
	
	private function updateCursorPos() : Void
	{
		cursorCounter %= texts.length;
		if (cursorCounter < 0) cursorCounter += texts.length;
		FlxTween.linearMotion(cursor, cursor.x, cursor.y, cursor.x, yOffset + ySpacing * cursorCounter, 0.5, true, { type : FlxTween.ONESHOT, ease : FlxEase.bounceOut} );
	}
}