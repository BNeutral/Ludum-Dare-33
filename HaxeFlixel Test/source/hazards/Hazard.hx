package hazards;
import characters.Player;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxMath;

class Hazard extends FlxSprite
{
	private var pushOpposite : Bool = false;
	private static inline var pushForce = 320;
	private var damagePerSecond : Float = 200;
	private var damagePerTouch : Float = 50;
	
	public function new(X : Float, Y : Float) 
	{
		super(X, Y);
	}
	
	public function overlapsPlayer(player : Player)
	{
		player.hurt(damagePerSecond * FlxG.elapsed + damagePerTouch);
		if (pushOpposite)
		{
			var thisCenterX : Float = this.x + this.width / 2;
			var thisCenterY : Float = this.y + this.height / 2;
			var playerCenterX : Float = player.x + player.width / 2;
			var playerCenterY : Float = player.y + player.height / 2;
			
			var normX : Float = playerCenterX - thisCenterX;
			var normY : Float = playerCenterY - thisCenterY;
			var dist : Float = Math.sqrt(normX*normX + normY*normY);
			normX /= dist;
			normY /= dist;
			
			player.velocity.x = normX * pushForce;
			player.velocity.y = normY * pushForce;
		}
	}
	
}