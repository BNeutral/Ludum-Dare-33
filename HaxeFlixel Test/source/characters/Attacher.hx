package characters;
import flixel.addons.display.FlxNestedSprite;
import flixel.FlxSprite;

/**
 * Class that can get thins attached
 */
class Attacher extends FlxSprite
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
		item.attach(this);
	}
	
}