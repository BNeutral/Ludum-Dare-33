package;

import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import spriteExtension.SwapBG;
import spriteExtension.SwapInterface;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{	
	private var swappables : Array<SwapInterface> = new Array<SwapInterface>();
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		this.bgColor = 0xFFFFFFFF;

		FlxG.sound.playMusic("assets/music/coldWorld1.mp3");
				
		var bg : SwapBG = new SwapBG(0, FlxG.height-561, ["assets/images/mounts.png", "assets/images/mounts_sketch.png"], 0.5);
		addSwappable(bg);
		
		var tree : SwapBG = new SwapBG(600, 200, ["assets/images/tree.png", "assets/images/tree_sketch.png"]);
		addSwappable(tree);
		
		var ground : SwapBG = new SwapBG(0, FlxG.height-139,["assets/images/floor.png", "assets/images/floor_sketch.png"]);
		addSwappable(ground);
		
		var player : Player = new Player(100, 400);
		addSwappable(player);
		
		var text : FlxText = new FlxText(0, 0, FlxG.width, "Press numerals to switch styles");
		text.color = 0xFF000000;
		text.alignment = "center";
		text.size = 32;
		text.scrollFactor.x = 0;
		add(text);
		
		FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER, new FlxPoint(0, 700));
	}
	
	/**
	 * Adds a swappable to both the state and the swap list
	 * @param	swappable
	 */
	private function addSwappable(swappable : SwapInterface)
	{
		swappables.push(swappable);
		add(cast(swappable, FlxBasic));
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
		
		if (FlxG.keys.justReleased.ONE)
		{
			swapAll(0);
		}
		if (FlxG.keys.justReleased.TWO)
		{
			swapAll(1);
		}
	}	
	
	private function swapAll(index : Int)
	{
		for (member in swappables)
		{
			member.swapGraphics(index);
		}
	}
}