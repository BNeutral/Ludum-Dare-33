package characters ;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.tweens.FlxTween;
import flixel.tweens.misc.AngleTween;
import spriteExtension.SwapSprite;

/**
 * Class for the player character
 */
class Player extends SwapSprite
{

	private var horizontalSpeedMultiplier : Int = 200;
	private var moveTween : AngleTween;
	
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
			this.flipX = true;
			this.facing = FlxObject.LEFT;
			if (moveTween == null || !moveTween.active)
			{
				moveTween = FlxTween.angle(this, -30, 30, 1, {type : FlxTween.PINGPONG});
			}
		}
		if (FlxG.keys.pressed.RIGHT)
		{
			velocity.x = horizontalSpeedMultiplier;
			this.flipX = false;
			this.facing = FlxObject.RIGHT;
			if (moveTween == null || !moveTween.active)
			{
				moveTween = FlxTween.angle(this, 30, -30, 1, {type : FlxTween.PINGPONG});
			}
		}
		
		if ((moveTween != null && moveTween.active) && !FlxG.keys.pressed.RIGHT && !FlxG.keys.pressed.LEFT)
		{
			moveTween.cancel();
			angle = 0;
		}
	}
	
}