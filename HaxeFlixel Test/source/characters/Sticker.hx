package characters;

import flixel.FlxSprite;

/**
 * Sticks to something at the center
 */
class Sticker extends FlxSprite
{
	private var stayOn : FlxSprite;
	
	public function new(stayOn : FlxSprite, ?SimpleGraphic : Dynamic) 
	{
		this.stayOn = stayOn;
		super(0, 0, SimpleGraphic);		
	}
	
	override public function update():Void 
	{
		x = stayOn.x + stayOn.width / 2 - width/2;
		y = stayOn.y + stayOn.height / 2 - height / 2;
		super.update();
			
	}
	
}