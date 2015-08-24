package mobs;
import characters.Player;
import flixel.FlxObject;

/**
 * Goblin that walks towards you if you're in a hittable spot
 */
class AgressiveGoblin extends EdibleMob
{
	private var player : Player;
	private static inline var minDist : Float = 320;
	private static inline var maxDist : Float = 400;
	private static inline var speed : Float = 240;
	private static inline var swordLen : Float = 34;
	
	
	public function new(X:Float, Y:Float, player : Player) 
	{
		super(X-60, Y-121);
		this.player = player;
		loadGraphic("assets/images/enemies/Enemy1 - SwordGoblin (125x121).png", true, 125, 121);
		animation.add("walk", [0, 1, 2, 3], 6);
		width -= 40;
		offset.x  = 20;
		height -= 30;
		offset.y = 25;
	}
	
	override public function update():Void 
	{
		var xDist : Float;
		if (player.x < x) xDist = x - (player.x + player.width);
		else xDist = player.x - (x + width);
		var dist : Float = Util.spriteDistance(this, player);
		
		if (hasItem)
		{
			if (dist < minDist && xDist > swordLen && (player.y+player.height) > y)
			{
				if (player.x < this.x) 
				{
					this.velocity.x = -speed;
					flipX = false;
				}
				else
				{
					this.velocity.x = speed;
					flipX = true;
				}
				if (isTouching(FlxObject.WALL) && isTouching(FlxObject.FLOOR))
				{
					velocity.y = -600;
				}
			}
			else
			{
				velocity.x = 0;
			}
		}
		else
		{
			if (dist < minDist)
			{
				if (player.x < this.x) 
				{
					this.velocity.x = speed/2;
					flipX = true;
				}
				else
				{
					this.velocity.x = -speed/2;
					flipX = false;
				}
				if (isTouching(FlxObject.WALL) && isTouching(FlxObject.FLOOR))
				{
					velocity.y = -600;
				}
			}
			else if (dist > maxDist) velocity.x = 0;
		}
		
		if (velocity.x != 0)
		{
			animation.play("walk");
		}
		else
		{
			animation.frameIndex = 0;
			animation.pause();
			if (player.x < this.x) 
			{
				flipX = false;
			}
			else
			{
				flipX = true;
			}
		}
		super.update();
	}
	
}