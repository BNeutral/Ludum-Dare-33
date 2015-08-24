package hazards;
import characters.Player;

class Flower extends Hazard
{

	public function new(X : Float, Y : Float) 
	{
		super(X, Y - 178);
		loadGraphic("assets/images/hazards/Enemy3 - Plant1 (146x184).png", true, 146, 184);
		animation.add("wiggle", [2, 3], 4, true);
		animation.add("slimeWiggle", [0, 1], 4, true);
		pushOpposite = false;
		damagePerTouch = 0;
		animation.play("wiggle");
		width -= 60;
		height -= 20;
		offset.y = 20;
		offset.x = 30;
	}
	
	override public function overlapsPlayer(player:Player) 
	{
		super.overlapsPlayer(player);
		animation.play("slimeWiggle");
	}
	
}