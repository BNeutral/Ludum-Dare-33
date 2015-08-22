package characters;
import flixel.FlxSprite;

class EdibleMob extends Attacher
{
	public var eatMass : Float = 400;

	public function new(X : Float, Y : Float) 
	{
		super(X, Y, "assets/images/slime.png");
		color = 0xffff0000;
		this.acceleration.y = Constants.gravity;
		this.maxVelocity.y = 500;
	}
	
}