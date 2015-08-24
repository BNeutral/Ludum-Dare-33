package hazards;
import characters.Player;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;

class Hazard extends FlxSprite
{
	private var pushOpposite : Bool = false;
	private var damagePerSecond : Float = 200;
	private var damagePerTouch : Float = 50;
	
	public function new(X : Float, Y : Float) 
	{
		super(X, Y);
		immovable = true;
	}
	
	public function overlapsPlayer(player : Player)
	{
		player.hurt(damagePerSecond * FlxG.elapsed + damagePerTouch);
		if (pushOpposite)
		{
			var point : FlxPoint = Util.spriteCenterNormalizedSubstraction(this, player);			
			player.velocity.x = point.x * Constants.pushForce;
			player.velocity.y = point.y * Constants.pushForce;
		}
	}
	
}