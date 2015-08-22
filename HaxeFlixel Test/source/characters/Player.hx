package characters ;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.tweens.misc.AngleTween;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;

/**
 * Class for the player character
 */
class Player extends FlxSprite
{
	private var speedMultiplier : Int = 200;
	private var jumpMultiplier : Int = 600;
	private var runThreshold : Float = 1;
	private var gravityVector : FlxPoint = new FlxPoint(0, 0);
	private var moveVector : FlxPoint = new FlxPoint(0, 0);
	private var maxVel : Float = 400;
	
	private var wasTouchingFloor : Bool = false;
	private var wasTouchingLeft : Bool = false;
	private var wasTouchingRight : Bool = false;
	private var wasTouchingCeil : Bool = false;
	
	public function new(x : Int, y : Int) 
	{
		super(x, y, "assets/images/player_placeholder.png");
		drag.x = 700;
		drag.y = 700;
		angularDrag = 700;
		
	}
	
	override public function update():Void 
	{
		movementUpdate();
		super.update();
	}
	
	private function movementUpdate() : Void
	{
		//var speed : Float = FlxMath.vectorLength(velocity.x, velocity.y);
		
		if (justTouched(FlxObject.CEILING))
		{
			maxVelocity.y = 0;
			maxVelocity.x = maxVel;
			gravityVector.x = moveVector.y = 0;
			gravityVector.y = moveVector.x = 1;
			if (wasTouchingLeft)
			{
				velocity.x = velocity.y;
				velocity.y = 0;
				x += 1;
			}
			if (wasTouchingRight)
			{
				velocity.x = -velocity.y;
				velocity.y = 0;
				x -= 1;
			}
		}
		else if (justTouched(FlxObject.WALL) && !justTouched(FlxObject.RIGHT))
		{
			gravityVector.x = moveVector.y = -1;
			gravityVector.y = moveVector.x = 0;
			maxVelocity.y = maxVel;
			maxVelocity.x = 0;
			
			if (wasTouchingFloor)
			{
				velocity.x = 0;
				velocity.y = velocity.x;
				y -= 1;
			}
			if (wasTouchingCeil)
			{
				velocity.x = 0;
				velocity.y = -velocity.x;
				y += 1;
			}
		}
		else if (justTouched(FlxObject.WALL) && !justTouched(FlxObject.LEFT))
		{
			gravityVector.x = moveVector.y = 1;
			gravityVector.y = moveVector.x = 0;
			maxVelocity.y = maxVel;
			maxVelocity.x = 0;
			
			if (wasTouchingFloor)
			{
				velocity.x = 0;
				velocity.y = -velocity.x;
				y -= 1;
			}
			if (wasTouchingCeil)
			{
				velocity.x = 0;
				velocity.y = velocity.x;
				y += 1;
			}
		}
		else if (justTouched(FlxObject.FLOOR) || !isTouching(FlxObject.ANY))
		{
			gravityVector.x = moveVector.y = 0;
			gravityVector.y = moveVector.x = -1;
			maxVelocity.y = 0;
			maxVelocity.x = maxVel;
		}
		
		acceleration.x = gravityVector.x * Constants.gravity;
		acceleration.y = - gravityVector.y * Constants.gravity;
		
		if (FlxG.keys.pressed.RIGHT)
		{
			acceleration.x -= speedMultiplier * moveVector.x;
			acceleration.y -= speedMultiplier * moveVector.y;
		}
		else if (FlxG.keys.pressed.LEFT)
		{
			acceleration.x += speedMultiplier * moveVector.x;
			acceleration.y += speedMultiplier * moveVector.y;
		}
		
		if (FlxG.keys.justPressed.UP && isTouching(FlxObject.ANY))
		{
			velocity.y += gravityVector.y * jumpMultiplier;
			velocity.x -= gravityVector.x * jumpMultiplier;
		}
		
		wasTouchingFloor = isTouching(FlxObject.FLOOR);
		wasTouchingLeft = (isTouching(FlxObject.WALL) && !isTouching(FlxObject.RIGHT));
		wasTouchingRight = (isTouching(FlxObject.WALL) && !isTouching(FlxObject.LEFT));
		wasTouchingCeil = isTouching(FlxObject.CEILING);
		
		
		if (FlxG.keys.pressed.RIGHT || FlxG.keys.pressed.LEFT) 
		{
			angularVelocity = velocity.x + velocity.y;
			if (wasTouchingRight) angularVelocity -= velocity.y * 2;
			if (wasTouchingCeil) angularVelocity -= velocity.x * 2;
		}		
		if (Math.abs(angularVelocity) < 0.1) angularVelocity = 0;
			
	}
	
}