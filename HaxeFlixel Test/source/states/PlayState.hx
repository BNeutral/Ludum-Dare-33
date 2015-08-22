package states;

import characters.Player;
import flixel.addons.editors.tiled.TiledMap;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{	

	private var colliders : FlxGroup = new FlxGroup();
	private var mapCollide : FlxTilemap;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		this.bgColor = 0xFFFFFFFF;

		//FlxG.sound.playMusic("assets/music/coldWorld1.mp3");
		
		var tiledMap : TiledMap = new TiledMap("assets/data/testmap.tmx");
		var flxMap : FlxTilemap	= new FlxTilemap();
		flxMap.widthInTiles = 16;
		flxMap.heightInTiles = 12;
		flxMap.loadMap(tiledMap.layers[0].tileArray, "assets/images/tileset_placeholder.png", 50, 50);
		mapCollide = flxMap;
		add(flxMap);
		
		var player : Player = new Player(100, 400);
		add(player);
		colliders.add(player);
						
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
	}	

}