package ;
import flixel.FlxG;
import flixel.FlxObject;
import spriteExtension.SwapSprite;

/**
 * Class for the player character
 */
class Player extends SwapSprite
{

	private var horizontalSpeedMultiplier : Int = 200;
	
	public function new(x : Int, y : Int) 
	{
		var graphics : Array<Dynamic> = ["assets/images/char.png", "assets/images/char_sketch.png"];
		super(x, y, graphics);
		drag.x = 1000;
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (FlxG.keys.pressed.LEFT)
		{
			velocity.x = -horizontalSpeedMultiplier;
			this.facing = FlxObject.LEFT;
		}
		if (FlxG.keys.pressed.RIGHT)
		{
			velocity.x = horizontalSpeedMultiplier;
			this.facing = FlxObject.RIGHT;
		}
	}
	
}