package states;

import characters.EdibleMob;
import characters.Item;
import characters.Player;
import flixel.addons.editors.tiled.TiledMap;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxCollision;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{	

	private var player : Player;
	private var colliders : FlxGroup = new FlxGroup(); // These collide with the stage
	private var edibles : FlxTypedGroup<EdibleMob> = new FlxTypedGroup<EdibleMob>(); // These can be eaten
	private var items : FlxTypedGroup<Item> = new FlxTypedGroup<Item> (); // These can be eaten
	private var playerItems : FlxTypedGroup<Item>  = new FlxTypedGroup<Item> (); // These can be eaten
	private var mapCollide : FlxTilemap;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		this.bgColor = 0xFFFFFFFF;

		FlxG.sound.playMusic("assets/music/Stage 1.mp3");
		
		add(new FlxSprite(0, 0, "assets/images/bg.png"));
		
		var tiledMap : TiledMap = new TiledMap("assets/data/testmap.tmx");
		var flxMap : FlxTilemap	= new FlxTilemap();
		flxMap.widthInTiles = 20;
		flxMap.heightInTiles = 15;
		flxMap.loadMap(tiledMap.layers[0].tileArray, "assets/images/tileset_placeholder.png", 40, 40);
		mapCollide = flxMap;
		add(flxMap);
		
		player = new Player(100, 400);
		add(player);
		colliders.add(player);
		
		var mob : EdibleMob = new EdibleMob(500, 400);
		add(mob);
		edibles.add(mob);
		colliders.add(mob);
	
		var item : Item = new Item(200, 400);
		add(item);
		colliders.add(item);
		items.add(item);
		
		//FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER, new FlxPoint(-200, 700));
	}

	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		FlxG.collide(mapCollide, colliders);
		FlxG.collide(player, edibles, eatMob);
		FlxG.collide(player, items, collideItem);
		holdTest();
	}	
	
	/**
	 * Function called when the player collides by an item held by no monster
	 * @param	obj1
	 * @param	obj2
	 */
	private function collideItem(obj1 : Player, obj2 : Item) : Void
	{
		if (obj2.owner == null) 
		{
			obj1.attach(obj2, 20);
			colliders.remove(obj2);
			items.remove(obj2);
			playerItems.add(obj2);
		}
	}
	
	/**
	 * Function called when a mob collides with the player
	 * @param	obj1
	 * @param	obj2
	 */
	private function eatMob(obj1 : Player, obj2 : EdibleMob) : Void
	{
		obj1.addMass(obj2.eatMass);
		obj2.kill();
		remove(obj2);
		edibles.remove(obj2);
		colliders.remove(obj2);
	}
	
	private function holdTest() : Void
	{
		for (item in playerItems)
		{
			if (player.scale.x < item.detachThreshold)
			{
				player.detach(item);
				colliders.add(item);
				items.add(item);
				playerItems.remove(item);
			}
		}
	}

}