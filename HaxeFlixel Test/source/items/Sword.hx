package items;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxPoint;

class Sword extends Item
{

	public function new(X:Float, Y:Float, collisionGroup:FlxGroup, itemsGroup:FlxTypedGroup<Item>) 
	{
		super(X, Y, "assets/images/items/sword.png", collisionGroup, itemsGroup);
		type = 2;
	}
	
	override public function onOverlapSprite(otherSprite:FlxSprite, item:Item) 
	{
		if (owner == null) return;
		otherSprite.hurt(750 * FlxG.elapsed);
		otherSprite.velocity.x = 0;
	}
	
	
}