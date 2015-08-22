package characters;
import flixel.addons.display.FlxNestedSprite;

/**
 * Class that can get thins attached
 */
class Attacher extends FlxNestedSprite
{

	public function new(X : Float, Y : Float, ?SimpleGraphic : Dynamic) 
	{
		super(X, Y, SimpleGraphic);
	}
	
	/**
	 * Attaches an item
	 */
	public function attach(item : Item, offset : Float)
	{
		centerOffsets();
		add(item);
		item.relativeAngle = angle;
		item.relativeX = x + width/2 - (item.x - item.width/2);
		item.relativeY = y + height / 2 - (item.y - item.height / 2);	
	}
	
}