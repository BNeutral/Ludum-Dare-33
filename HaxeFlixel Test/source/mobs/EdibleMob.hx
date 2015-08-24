package mobs ;
import characters.Attacher;
import flixel.FlxSprite;

class EdibleMob extends Attacher
{
	public var eatMass : Float = 400;

	public function new(X : Float, Y : Float) 
	{
		super(X, Y);
		this.acceleration.y = Constants.gravity;
		this.maxVelocity.y = 500;
	}
	
	override public function hurt(Damage:Float):Void 
	{
		//super.hurt(Damage);
	}
	
	override public function update():Void 
	{
		super.update();
		if (!inWorldBounds()) kill();
	}
}