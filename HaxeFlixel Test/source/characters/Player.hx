package characters ;
import flixel.addons.display.FlxNestedSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.tweens.FlxTween;
import flixel.tweens.misc.AngleTween;
import flixel.tweens.misc.ColorTween;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;

/**
 * Class for the player character
 */
class Player extends Attacher
{
	private var baseSpeed : Float = 200;
	private var speedMultiplier : Float = 200;
	private var jumpMultiplier : Float = 600;
	private var runThreshold : Float = 1;
	private var gravityVector : FlxPoint = new FlxPoint(0, 0);
	private var moveVector : FlxPoint = new FlxPoint(0, 0);
	private var maxVel : Float = 400;
	private var slimeLostRolling : Float = 0.0001;
	
	public var wasTouchingFloor : Bool = false;
	public var wasTouchingLeft : Bool = false;
	public var wasTouchingRight : Bool = false;
	public var wasTouchingCeil : Bool = false;
	public var wasTouchingAny : Bool = false;
	public var wasMoving : Bool = false;
	
	private var origWidth : Float;
	private var origHeight : Float;
	private var origOffx : Float;
	private var origOffy : Float;
	public var currentSize : Float = 1;
	
	private var moveSound : FlxSound = new FlxSound();
	private var hurtSound : FlxSound = new FlxSound();
	
	private var invuln : Bool = false;
	
	public function new(x : Int, y : Int) 
	{
		super(x, y, "assets/images/slime.png");
		drag.x = 700;
		drag.y = 700;
		angularDrag = 700;
		origOffx = offset.x = width / 6;
		origOffy = offset.y = height / 6;
		width -= width / 3;
		height -= height / 3;		
		origWidth = width;
		origHeight = height;
		moveSound.loadEmbedded("assets/sounds/SlimeMovement.mp3", true);
		hurtSound.loadEmbedded("assets/sounds/SlimeDamage.mp3", false, false);
		moveSound.play();
		flipX = true;
		
	}
	
	override public function destroy():Void 
	{
		super.destroy();
		moveSound.stop();
	}
	
	private var colTween : FlxTween;
	override public function hurt(Damage:Float):Void 
	{
		addMass( -Damage);	
		if (Damage > 0)
		{
			FlxTween.color(this, 0.2, 0xFF0000, 0xFFFFFF, 1, 1, { type : FlxTween.ONESHOT } );
			hurtSound.play(false);
		}
	}
		
	override public function update():Void 
	{
		movementUpdate();
		soundUpdate();
		speedMultiplier = baseSpeed / currentSize;
		super.update();
	}
	
	override public function kill():Void 
	{
		super.kill();
		moveSound.stop();
	}
	
	/**
	 * Spunds stuff
	 */
	private function soundUpdate()
	{
		if (justTouched(FlxObject.ANY) && !wasTouchingCeil && !wasTouchingFloor && !wasTouchingLeft && !wasTouchingRight)
		{
			FlxG.sound.play("assets/sounds/SlimeLand.wav");
		}
		if (wasMoving)
			moveSound.volume = (Math.abs(velocity.y) + Math.abs(velocity.x)) / maxVel;
		else
			moveSound.volume = 0;
	}
	
	/**
	 * Adds to the slime's mass. The original slime can be said to have 1000 mass
	 * @param	Float	Amount of mass to add (or substract!)
	 */
	public function addMass(mass : Float) : Void
	{
		adjustSize(currentSize+mass / 1000);
	}
	
	/**
	 * Changes the slime size to that specified in the multiplier
	 * @param	multiplier		A float > 0
	 */
	private function adjustSize(multiplier : Float)
	{
		scale.x = multiplier;
		scale.y = multiplier;
		var diffX : Float = (width - multiplier * origWidth);
		var diffY : Float = (height - multiplier * origHeight);
		x += diffX / 2;
		y += diffY;		
		width = multiplier * origWidth;
		height = multiplier * origHeight;
		centerOrigin();
		centerOffsets();
		currentSize = multiplier;
		if (wasTouchingFloor) y -= 1;
		if (wasTouchingLeft) x += 1;
		if (wasTouchingRight) x -= 1;
		if (wasTouchingCeil) y += 1;
	}
		
	/**
	 * Does a lot of bullshit so this slime moves on walls
	 */
	private function movementUpdate() : Void
	{
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
			velocity.y += gravityVector.y * jumpMultiplier * currentSize;
			velocity.x -= gravityVector.x * jumpMultiplier * currentSize;
			FlxG.sound.play("assets/sounds/SlimeJump.mp3");
		}
		
		wasTouchingFloor = isTouching(FlxObject.FLOOR);
		wasTouchingLeft = (isTouching(FlxObject.WALL) && !isTouching(FlxObject.RIGHT));
		wasTouchingRight = (isTouching(FlxObject.WALL) && !isTouching(FlxObject.LEFT));
		wasTouchingCeil = isTouching(FlxObject.CEILING);
		
		if (isTouching(FlxObject.ANY))
		{
			adjustSize(currentSize - slimeLostRolling * (FlxMath.vectorLength(velocity.x, velocity.y)) * FlxG.elapsed);
		}
		
		if (FlxG.keys.pressed.RIGHT || FlxG.keys.pressed.LEFT) 
		{
			angularVelocity = (velocity.x + velocity.y)*(1/currentSize);
			if (wasTouchingRight) angularVelocity -= velocity.y * 2 *(1/currentSize);
			if (wasTouchingCeil) angularVelocity -= velocity.x * 2 *(1/currentSize);
		}		
		
		wasMoving = ( ((isTouching(FlxObject.FLOOR) || isTouching(FlxObject.CEILING)) && (Math.abs(velocity.x) > 1))
			|| 	( (isTouching(FlxObject.WALL) && (Math.abs(velocity.y) > 1))));
			
	}
	
}