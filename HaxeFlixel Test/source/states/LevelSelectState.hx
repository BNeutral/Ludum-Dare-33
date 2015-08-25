package states;
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import buttons.TextWithCallback;
import flixel.util.FlxSpriteUtil;
import openfl.display.BitmapData;

class LevelSelectState extends FlxState
{
	private var texts : Array<TextWithCallback> = new Array<TextWithCallback>();
	private var cursor : FlxSprite = new FlxSprite(220, 0, "assets/images/slimeIcon.png");
	private var cursorCounter : Int = 0;
	
	private static inline var yOffset : Int = 0;
	private static inline var ySpacing : Int = 40;
	
	var numberLevels : Int = 0;
	
	override public function create():Void
	{
		super.create();
		this.bgColor = 0xFF000000;
		
		numberLevels = Reg.levels.length;
		for (i in 0...numberLevels)
		{
			addOption("STAGE "+i, function() { FlxG.switchState(new PlayState(i)); } );
		}
		
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
	