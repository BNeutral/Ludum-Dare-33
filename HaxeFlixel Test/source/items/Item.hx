package items;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxMath;
import openfl.display.BitmapData;

class Item extends FlxSprite
{
	public var owner : FlxSprite = null;
	public var angleOffset : Float = 0;
	public var radius : Float = 0;
	public var detachThreshold : Float = 0.3;

	public function new(X : Float, Y : Float) 
	{
		super(X, Y, "assets/images/items/sword.png");
		this.maxVelocity.y = 500;
		width = height = (width+height)/2;
		centerOffsets();
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
		radius = target.width + target.offset.x;
		angleOffset = target.angle; //+Util.toDegrees(Math.atan2( (y + height / 2) - (target.y + target.height / 2), (x + width / 2) - (target.x + target.width / 2)));
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
		super.update();
		if (owner == null) acceleration.y = Constants.gravity;
		else 
		{
			acceleration.y = 0;
			x = owner.x + owner.width / 2 - width/2 + radius * owner.scale.x/2 * Math.cos(Util.toRadians(owner.angle+angleOffset));
			y = owner.y + owner.height / 2 - height/2 + radius * owner.scale.y/2 * Math.sin(Util.toRadians(owner.angle+angleOffset));
			angle = owner.angle+angleOffset;
		}		
		
	}
	
}