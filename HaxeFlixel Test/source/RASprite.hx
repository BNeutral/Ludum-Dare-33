package;

import flixel.FlxSprite;
import spriteExtension.SwapSprite;

/**
 * ...
 * @author ...
 */
class RASprite extends SwapSprite
{

	public function new(X:Float=0, Y:Float=0, SimpleGraphic:Dynamic) 
	{
		super(X, Y, SimpleGraphic);
		
	}
	
	//This works but its really hack-y.
	//A smarter solution would involve knowing how far it is from one edge to another.
	override public function update():Void
	{
		super.update();
		
		if (this.isOnScreen() == false)
		{
			this.setPosition(x + 1300, y);
		}
	}
	
}


	