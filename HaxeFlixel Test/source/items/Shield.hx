package items;

import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxPoint;
import flixel.FlxSprite;

class Shield extends Item
{
	
	public function new(X : Float, Y : Float, collisionGroup : FlxGroup, itemsGroup : FlxTypedGroup<Item>) 
	{
		super(X, Y, "assets/images/items/shield.png", collisionGroup, itemsGroup);
		type = 1;
	}
	
	override public function onOverlapSprite(otherSprite:FlxSprite, item:Item) 
	{
		if (owner == null) return;
		var point : FlxPoint = Util.spriteCenterNormalizedSubstraction(this, otherSprite);			
		otherSprite.velocity.x = point.x * Constants.pushForce;
		otherSprite.velocity.y = point.y * Constants.pushForce;
	}
	
	override public function onOverlapItem(otherItem:Item, item:Item) 
	{
		if (owner == null) return;
		super.onOverlapItem(otherItem, item);
		if (otherItem.type == 2) otherItem.detach();
	}
	
}