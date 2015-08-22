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

	public function new(X : Float, Y : Float) 
	{
		super(X, Y, new BitmapData(24, 24));
		this.maxVelocity.y = 500;
	}
	
	/**
	 * Makes the object attach itself to the target
	 * @param	target
	 */
	public function attach(target : FlxSprite)
	{
		owner = target;
		radius = Math.sqrt( Math.pow((this.x + this._halfWidth) - (target.x + target.offset.x + target.width / 2), 2) + 
							Math.pow((this.y + this._halfHeight) - (target.y + target.offset.y +  target.height / 2), 2));
		angleOffset = target.angle;
	}
	
	override public function update():Void 
	{
		super.update();
		if (owner == null) acceleration.y = Constants.gravity;
		else 
		{
			acceleration.y = 0;
			x = (owner.x - owner.offset.x + owner.width / 2) + radius * owner.scale.x * Math.cos(Util.toRadians(owner.angle+angleOffset));
			y = (owner.y - owner.offset.y + owner.height / 2) + radius * owner.scale.y * Math.sin(Util.toRadians(owner.angle+angleOffset));
			trace(owner.width / 2);
		}
		
	}
	
}