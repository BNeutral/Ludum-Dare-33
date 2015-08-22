package characters;
import flixel.addons.display.FlxNestedSprite;
import flixel.FlxObject;
import openfl.display.BitmapData;

class Item extends FlxNestedSprite
{
	public var owner : FlxObject = null;

	public function new(X : Float, Y : Float) 
	{
		super(X, Y, new BitmapData(24, 24));
		this.maxVelocity.y = 500;
	}
	
	override public function update():Void 
	{
		super.update();
		if (owner == null) acceleration.y = Constants.gravity;
		else acceleration.y = 0;
	}
	
}