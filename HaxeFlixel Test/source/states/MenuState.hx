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
	private var cursor : FlxSprite = new FlxSprite(220, 0, new BitmapData(32, 32));
	private var cursorCounter : Int = 0;
	
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
		addOption("CREDITS", function(){ FlxG.switchState(new CreditsState()); } );
		updateCursorPos();
		add(cursor);		
		FlxTween.angle(cursor, 0, 90, 1, { type : FlxTween.LOOPING, ease : FlxEase.bounceOut } );
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