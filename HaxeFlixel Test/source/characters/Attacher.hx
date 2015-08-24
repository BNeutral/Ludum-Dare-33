package characters;
import flixel.addons.display.FlxNestedSprite;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import items.Item;

/**
 * Class that can get thins attached
 */
class Attacher extends FlxSprite
{

	public var hasItem : Bool = false;
	
	public function new(X : Float, Y : Float, ?SimpleGraphic : Dynamic) 
	{
		super(X, Y, SimpleGraphic);
	}
	
	/**
	 * Attaches an item
	 */
	public function attach(item : Item, group : FlxTypedGroup<Item>, offset : Float)
	{
		item.attach(this, group, offset);
		hasItem = true;
	}
	
	public function detach(item : Item)
	{
		item.detach();
	}
	
}