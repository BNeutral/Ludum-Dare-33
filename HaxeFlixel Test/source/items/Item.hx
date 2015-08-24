package items;
import characters.Attacher;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxMath;
import openfl.display.BitmapData;

class Item extends FlxSprite
{
	public var owner : Attacher = null;
	public var group : FlxTypedGroup<Item> = null;
	public var angleOffset : Float = 0;
	public var radius : Float = 0;
	public var detachThreshold : Float = 0.75;
	public var type : Int = 0;
	private var collisionGroup : FlxGroup;
	private var itemsGroup : FlxTypedGroup<Item>;
	private var hadOwner : Bool;

	public function new(X : Float, Y : Float, graphic : Dynamic, collisionGroup : FlxGroup, itemsGroup : FlxTypedGroup<Item>) 
	{
		super(X, Y, graphic);
		this.maxVelocity.y = 500;
		width = height = (width+height)/2;
		centerOffsets();
		this.drag.x = 1000;
		this.drag.y = 1000;
		this.collisionGroup = collisionGroup;
		this.itemsGroup = itemsGroup;
	}
	
	/**
	 * Makes the object attach itself to the target
	 * @param	target
	 */
	public function attach(target : Attacher, group : FlxTypedGroup<Item>, customOffset : Float = 0) : Void
	{
		owner = target;
		owner.hasItem = true;
		this.group = group;
		collisionGroup.remove(this);
		group.add(this);
		radius = target.width + target.offset.x;
		angleOffset = target.angle + customOffset;
		hadOwner = true;
	}
	
	/**
	 * Makes the object detach itself from anything
	 */
	public function detach() : Void
	{
		if (owner != null) owner.hasItem = false;
		group.remove(this);
		collisionGroup.add(this);
		itemsGroup.add(this);
		owner = null;
		velocity.y = -500;
	}
	
	override public function update():Void 
	{
		super.update();
		if ((owner == null || !owner.alive) && hadOwner) 
		{
			detach();
			acceleration.y = Constants.gravity;
			hadOwner = false;
		}
		
		if (owner != null)
		{
			var extraRot : Float = 0;
			if (owner.flipX)
			{
				flipY = false;
				extraRot = angleOffset % 360;
				if (extraRot > 180) extraRot = 180 + 360 - extraRot - angleOffset;
				else extraRot = 180 - extraRot - angleOffset;
			}
			else
			{
				flipY = true;
			}
			acceleration.y = 0;
			x = owner.x + owner.width / 2 - width/2 + radius * owner.scale.x/2 * Math.cos(Util.toRadians(owner.angle+angleOffset+extraRot));
			y = owner.y + owner.height / 2 - height/2 + radius * owner.scale.y/2 * Math.sin(Util.toRadians(owner.angle+angleOffset+extraRot));
			angle = owner.angle+angleOffset+extraRot;
		}		
	}
	
	public function onOverlapSprite(otherSprite : FlxSprite, item : Item)
	{
		if (owner == null) return;
	}
	
	public function onOverlapItem(otherItem : Item, item : Item)
	{
		if (owner == null) return;
	}
	
}