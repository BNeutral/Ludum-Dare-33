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
	
	override public function update():Void
	{
		super.update();
		
		//if (this.isOnScreen() == false)
		{
			this.x = 250; 
			this.y = 110;
		}
	}
	
}


	