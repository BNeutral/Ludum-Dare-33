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
	
}