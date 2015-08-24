package hazards;

class Spike extends Hazard
{

	public function new(X : Float, Y : Float, graphics : String) 
	{
		super(X, Y);
		loadGraphic(graphics);
		pushOpposite = true;
		damagePerSecond = 0;
	}
	
}