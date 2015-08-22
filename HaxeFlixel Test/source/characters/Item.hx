package characters;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxMath;
import openfl.display.BitmapData;

class Item extends FlxSprite
{
	public var owner : FlxSprite = null;
	private var angleOffset : Float = 0;
	private var radius : Float = 0;
	public var detachThreshold : Float = 0.3;

	public function new(X : Float, Y : Float) 
	{
		super(X, Y, "assets/images/items/sword.png");
		this.maxVelocity.y = 500;
		this.drag.x = 1000;
		this.drag.y = 1000;
	}
	
	/**
	 * Makes the object attach itself to the target
	 * @param	target
	 */
	public function attach(target : FlxSprite) : Void
	{
		owner = target;
		radius = Math.sqrt( Math.pow((x + _halfWidth) - (target.x + target.offset.x + target.width / 2), 2) + 
							Math.pow((y + _halfHeight) - (target.y + target.offset.y +  target.height / 2), 2))
							+_halfWidth;
		//angleOffset = target.angle;
	}
	
	/**
	 * Makes the object detach itself from anything
	 */
	public function detach() : Void
	{
		owner = null;
	}
	
	override public function update():Void 
	{
		
		if (owner == null) acceleration.y = Constants.gravity;
		else 
		{
			acceleration.y = 0;
			x = (owner.x - owner.offset.x*owner.scale.x + owner.width / 2) + radius * owner.scale.x * Math.cos(Util.toRadians(owner.angle+angleOffset));
			y = (owner.y - owner.offset.y*owner.scale.y + owner.height / 2) + radius * owner.scale.y * Math.sin(Util.toRadians(owner.angle+angleOffset));			
			angle = owner.angle+angleOffset;
		}		
		super.update();
	}
	
}