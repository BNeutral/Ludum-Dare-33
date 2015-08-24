package characters;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import openfl.display.BitmapData;
import ui.PercentDisplay;

class Chest extends FlxGroup
{
	private var chest1 : FlxSprite;
	private var chest2 : FlxSprite;
	private var chest3 : FlxSprite;
	private var chest4 : FlxSprite;
	private var chest5 : FlxSprite;
	private var border : FlxObject;
	private var sweetspot : FlxObject; // To check for level exit
	private var player : Player;
	private var open : Bool = false;
	private var levelEndCallback : Void->Void;
	private var counter : PercentDisplay;
	private var counterThreshold : Int;

	public function new(X : Float, Y : Float, under : FlxGroup, mid : FlxGroup, top : FlxGroup, collision : FlxGroup, player : Player, counter : PercentDisplay, levelEndCallback : Void->Void, counterThreshold : Int = 70 ) 
	{
		super();
		this.player = player;
		this.levelEndCallback = levelEndCallback;
		this.counter = counter;
		this.counterThreshold = counterThreshold;
		
		chest1 = new FlxSprite(X, Y-349, "assets/images/chest/Chest1.png");
		chest2 = new FlxSprite(X, Y-349, "assets/images/chest/Chest2 - Door.png");
		chest3 = new FlxSprite(X, Y-349, "assets/images/chest/Chest3.png");
		chest4 = new FlxSprite(X, Y-349, "assets/images/chest/Chest5.png");
		chest5 = new FlxSprite(X, Y - 349, "assets/images/chest/Chest4.png");
		sweetspot = new FlxObject(X + 320, Y + 200 - 349, 30, 170);
		border = new FlxObject(X + 160, Y + 110 - 349, 240, 240);
		border.allowCollisions = FlxObject.UP | FlxObject.RIGHT | FlxObject.DOWN;
		
		chest1.immovable = true;
		chest2.immovable = true;
		chest3.immovable = true;
		chest4.immovable = true;
		chest5.immovable = true;
		border.immovable = true;
		sweetspot.immovable = true;
		
		collision.add(chest2);		
		collision.add(border);
		
		under.add(chest1);
		under.add(chest2);
		top.add(chest3);
		top.add(chest5);
		top.add(chest4);
		
		var text : FlxText = new FlxText(X + 260, Y - 349 +26, 50, "" + counterThreshold + "%", 16, true);
		text.font = "assets/fonts/DJB Speak Softly.ttf";
		text.color = 0x00A000;
		top.add(text);
		
		chest2.height = 240;
		chest2.width = 150;
		chest2.y = chest3.y = chest5.y + (chest5.height - 240);
		chest2.x = chest5.x + 60;
		
		chest2.offset.y = chest3.offset.y = chest5.height - 240;
		chest2.offset.x = 60;
		
		chest1.solid = chest3.solid = chest5.solid = chest4.solid = false;
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (!open)
		{
			if (counter.currentNumber >= counterThreshold)
			{
				chest2.solid = false;
				FlxTween.tween(chest2, { x : chest2.x - 100 }, 1, { type : FlxTween.ONESHOT, ease : FlxEase.bounceOut } );
				open = true;				
			}
		}
		else
		{
			if (sweetspot.overlaps(player)) levelEndCallback();
		}
	}
	
}