package mobs;
import characters.Player;
import flixel.FlxObject;
import flixel.tile.FlxTilemap;

/**
 * A cute shy goblin that will run away from you
 */
class ShyGoblin extends EdibleMob
{
	private var player : Player;
	private static inline var minDist : Float = 200;
	private static inline var maxDist : Float = 500;
	private static inline var speed : Float = 160;
	
	public function new(X:Float, Y:Float, player : Player) 
	{
		super(X-60, Y-121);
		this.player = player;
		loadGraphic("assets/images/enemies/Enemy1 - Goblin (125x121).png", true, 125, 121);
		animation.add("walk", [0, 1, 2, 3], 4);
		width -= 40;
		offset.x  = 20;
		height -= 30;
		offset.y = 25;
	}
	
	override public function update():Void 
	{
		var dist : Float = Util.spriteDistance(this, player);
		if (dist < minDist)
		{
			if (player.x < this.x) 
			{
				this.velocity.x = speed;
				flipX = true;
			}
			else
			{
				this.velocity.x = -speed;
				flipX = false;
			}
			if (isTouching(FlxObject.WALL) && isTouching(FlxObject.FLOOR))
			{
				velocity.y = -600;
			}
		}
		else if (dist > maxDist) velocity.x = 0;
		
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