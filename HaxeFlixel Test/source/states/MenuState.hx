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
	private var cursor : FlxSprite = new FlxSprite(220, 0, "assets/images/slimeIcon.png");
	private var cursorCounter : Int = 0;
	
	private var logo : FlxSprite = new FlxSprite(22, 15, "assets/images/menUI/menuLogo.png");
	
	private var but1 : FlxSprite = new FlxSprite(550, 40, "assets/images/menUI/button1.png");
	private var but2 : FlxSprite = new FlxSprite(550, 125, "assets/images/menUI/button2.png");
	private var but3 : FlxSprite = new FlxSprite(550, 200, "assets/images/menUI/button3.png");
	
	private var menuBack : FlxSprite = new FlxSprite(15, 15, "assets/images/menUI/menuLogo.png");
	private var menuGround : FlxSprite = new FlxSprite(15, 15, "assets/images/menUI/menuLogo.png");
	
	private var menuChest : FlxSprite = new FlxSprite(15, 15, "assets/images/menUI/menuLogo.png");
	private var menuSlimes : FlxSprite = new FlxSprite(15, 15, "assets/images/menUI/menuLogo.png");
	
	private static inline var yOffset : Int = 300;
	private static inline var ySpacing : Int = 60;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		addOption("NEW GAME", function() { FlxG.switchState(new PlayState()); } );
		addOption("LEVEL SELECT", function(){ FlxG.switchState(new LevelSelectState()); } );
		//addOption("CONTROLS", function(){ FlxG.switchState(new ControlsState()); } );
		addOption("CREDITS", function() { FlxG.switchState(new CreditsState()); } );
		
		updateCursorPos();
		add(cursor);
		
		add(logo);
		
		add(but1);
		add(but2);
		add(but3);
		
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
		}
		if (FlxG.keys.justPressed.DOWN)
		{
			++cursorCounter;
			updateCursorPos();
		}
		if (FlxG.keys.justPressed.ENTER) texts[cursorCounter].callback();
	}
	
	private function updateCursorPos() : Void
	{
		cursorCounter %= texts.length;
		if (cursorCounter < 0) cursorCounter += texts.length;
		FlxTween.linearMotion(cursor, cursor.x, cursor.y, cursor.x, yOffset + ySpacing * cursorCounter, 0.5, true, { type : FlxTween.ONESHOT, ease : FlxEase.bounceOut} );
	}
}