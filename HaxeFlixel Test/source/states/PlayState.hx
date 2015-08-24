package states;

import characters.Chest;
import hazards.Flower;
import hazards.Hazard;
import hazards.Spike;
import mobs.EdibleMob;
import characters.Owl;
import characters.Sticker;
import flixel.addons.display.FlxBackdrop;
import flixel.tweens.FlxEase;
import flixel.util.FlxRect;
import items.Item;
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
import lime.utils.ByteArray;
import painting.SlimeCanvas;
import painting.SlimeEmitter;
import ui.PercentDisplay;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{	
	private var layer1 : FlxGroup; //Bottomost layer, add to these instead of the state
	private var layer2 : FlxGroup;
	private var layer3 : FlxGroup;

	private var player : Player;
	private var stageCollisionExtra : FlxGroup;
	private var colliders : FlxGroup; // These collide with the stage
	private var edibles : FlxTypedGroup<EdibleMob>; // These can be eaten
	private var items : FlxTypedGroup<Item>; // These can be eaten
	private var playerItems : FlxTypedGroup<Item>; // These can be eaten
	private var hazards : FlxTypedGroup<Hazard>; // These can be eaten
	private var mapCollide : FlxTilemap;
	private var slimeCanvas : SlimeCanvas;
	private var counter : PercentDisplay;
	
	private var levelNumber : Int;
	private var data : Xml = null;
	
	public function new(levelNumber : Int = -1, data : Xml = null)
	{
		super();
		this.levelNumber = levelNumber;
		this.data = data;
	}
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		FlxTween.manager.clear();
		
		layer1 = new FlxGroup();
		layer2 = new FlxGroup();
		layer3 = new FlxGroup();
		colliders = new FlxGroup();
		stageCollisionExtra = new FlxGroup();
		edibles = new FlxTypedGroup<EdibleMob>();
		items = new FlxTypedGroup<Item>();
		playerItems = new FlxTypedGroup<Item>();
		hazards = new FlxTypedGroup<Hazard>();
		
		this.bgColor = 0xFFFFFFFF;

		FlxG.sound.playMusic("assets/music/Compressed/Stage 1 (Comp).mp3");
		
		var bg : FlxBackdrop = new FlxBackdrop("assets/images/bg.png", 1, 1, true, false);
		bg.scrollFactor.x = 0.5;
		bg.scrollFactor.y = 0;
		add(bg);
				
		var tiledMap : TiledMap;
		if (data == null) 
		{
			tiledMap = new TiledMap("assets/data/mobtestmap.tmx");
		}
		else
		{
			tiledMap = new TiledMap(data);
		}
		var flxMapBG1 : FlxTilemap	= new FlxTilemap();
		var flxMapBG2 : FlxTilemap	= new FlxTilemap();
		var flxMapBG3 : FlxTilemap	= new FlxTilemap();
		var flxMap : FlxTilemap	= new FlxTilemap();
		
		flxMapBG1.widthInTiles = flxMapBG2.widthInTiles = flxMapBG3.widthInTiles = flxMap.widthInTiles = tiledMap.width;
		flxMapBG1.heightInTiles = flxMapBG2.heightInTiles = flxMapBG3.heightInTiles = flxMap.heightInTiles = tiledMap.height;
		flxMapBG1.loadMap(tiledMap.getLayer("Bg1").tileArray, "assets/images/tileset.png", 40, 40, 0, 1);
		flxMapBG2.loadMap(tiledMap.getLayer("Bg2").tileArray, "assets/images/tileset.png", 40, 40, 0 , 1);
		flxMapBG3.loadMap(tiledMap.getLayer("Bg3").tileArray, "assets/images/tileset.png", 40, 40, 0 , 1);
		flxMap.loadMap(tiledMap.getLayer("Solid Tiles").tileArray, "assets/images/tileset.png", 40, 40, 0, 1);
		mapCollide = flxMap;
		
		add(flxMapBG1);
		add(flxMapBG2);
		add(flxMapBG3);
		add(flxMap);
				
		slimeCanvas = new SlimeCanvas(tiledMap.width*40, tiledMap.height*40);
		add(slimeCanvas);
		
		add(layer1);
		add(layer2);
		add(layer3);
		
		counter = new PercentDisplay(40000, slimeCanvas);
		add(counter);
		
		loadCharsFromTilemap(tiledMap.getLayer("PCs").tileArray, tiledMap.width, tiledMap.height);
		
		FlxG.worldBounds.set(0, 0, tiledMap.width * 40, tiledMap.height * 40);
		FlxG.camera.bounds = new FlxRect(0, 0, tiledMap.width * 40, tiledMap.height * 40);
		FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
		FlxG.camera.setPosition(0, 0);
	}
	
	/**
	 * Loads all extra things from the tilmap
	 */
	private function loadCharsFromTilemap(tiles : Array<Int>, widthInTiles : Int, heightInTiles : Int)
	{
		var totalTiles : Int = widthInTiles * heightInTiles;
		
		var owlCounter : Int = 0;
		
		var playerIndex = tiles.indexOf(496); // player;
		var x : Int = (playerIndex % widthInTiles) * 40;
		var y : Int = cast(playerIndex / widthInTiles,Int) * 40;
				
		player = new Player(x, y);
		player.y -= player.height;
		colliders.add(player);					
		var emitter : SlimeEmitter = new SlimeEmitter(player, mapCollide, slimeCanvas);
		
		for (i in 0...totalTiles)
		{
			x = (i % widthInTiles) * 40;
			y = cast(i / widthInTiles,Int) * 40;
			switch (tiles[i])
			{
				case 451: // Spike ^
					addHazard(new Spike(x, y, "assets/images/hazards/spike1.png"));
				case 452: // Spike >
					addHazard(new Spike(x, y, "assets/images/hazards/spike2.png"));
				case 453: // Spike <
					addHazard(new Spike(x, y, "assets/images/hazards/spike3.png"));
				case 454: // Spike v
					addHazard(new Spike(x, y, "assets/images/hazards/spike4.png"));
				case 497: // EXT
					add(new Chest(x, y + 65, layer1, layer2, layer3, stageCollisionExtra, player, counter, wonLevel, 20));
				case 503: // Plant
					addHazard(new Flower(x, y+40));
				case 504: // Owl
					layer1.add(new Owl(x, y - 107 + 40, levelNumber, owlCounter++));
			}
		}
		
		layer2.add(new Sticker(player, "assets/images/slime_crown.png"));
		layer2.add(emitter);
		layer2.add(player);
	}

	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
		player.destroy();
	}
	
	private function addHazard(hazard : Hazard) : Void
	{
		hazards.add(hazard);
		layer2.add(hazard);
	}
	
	/**
	 * Function to be called when you clear a level
	 */
	private function wonLevel()
	{
		FlxG.switchState(new MenuState());
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		FlxG.collide(mapCollide, colliders);
		FlxG.collide(stageCollisionExtra, colliders);
		FlxG.collide(player, edibles, eatMob);
		FlxG.overlap(player, items, collideItem);
		FlxG.overlap(player, hazards, overlapHazard);
		holdTest();
		
		if (player.alive && (player.currentSize < 0.5 || !player.inWorldBounds()))
		{
			player.kill();
			var gameOver : FlxSprite = new FlxSprite(0, 0, "assets/images/UI/GameOverLay.png");
			gameOver.y = -gameOver.height;
			gameOver.x = FlxG.width / 2 - gameOver.width / 2;
			gameOver.scrollFactor.set(0, 0);
			add(gameOver);
			FlxTween.tween(gameOver, { y : (FlxG.height/2 - gameOver.height/2) } , 1, { ease : FlxEase.bounceOut } );
		}
		
		if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(new MenuState());
		if (FlxG.keys.justPressed.R) FlxG.switchState(new PlayState());
	}	
	
	private function overlapHazard(obj1 : Player, obj2 : Hazard) : Void
	{
		obj2.overlapsPlayer(obj1);
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
	
	/**
	 * Checks if the player should drop the items it holds
	 */
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