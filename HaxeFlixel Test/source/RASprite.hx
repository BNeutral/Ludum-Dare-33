package;

import flixel.FlxG;
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
	//This is a smarter solution than the last one but I still need a way to compare the cameras x to this's x.
	//To avoid the walking backwards problem.
	override public function update():Void
	{
		super.update();
		
		if (this.isOnScreen() == false)
		{
			this.setPosition((x + FlxG.camera.width + 199), y);
		}
	}
	
}


	