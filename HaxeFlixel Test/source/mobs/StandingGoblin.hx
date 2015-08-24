package mobs;

/**
 * A goblin that does nothing
 */
class StandingGoblin extends EdibleMob
{

	public function new(X : Float, Y :Float) 
	{
		super(X, Y);
		loadGraphic("assets/images/enemies/Enemy1 - Shield Goblin (No Shield).png");
		y -= height;
		
		width -= 120;
		offset.x  = 60;
		height -= 40;
		offset.y = 30;
		x -= width / 2;
	}
	
}