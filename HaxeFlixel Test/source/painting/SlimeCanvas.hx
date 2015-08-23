package painting;

import flixel.FlxSprite;
import openfl.display.BitmapData;

/**
 * Class to paint slime on stage tiles
 */
class SlimeCanvas extends FlxSprite
{
	private static var brush1 : FlxSprite = new FlxSprite(0, 0, new BitmapData(4, 4, true, 0xa000ff00));
	private static var brush2 : FlxSprite = new FlxSprite(0, 0, new BitmapData(6, 6, true, 0xa000ff00));
	private static var brush3 : FlxSprite = new FlxSprite(0, 0, new BitmapData(4, 8, true, 0xa000ff00));
	private static var brush4 : FlxSprite = new FlxSprite(0, 0, new BitmapData(6, 10, true, 0xa000ff00));
	private static var brushes : Array<FlxSprite> = [brush1, brush2, brush3, brush4];
	
	public function new(width : Int, height : Int) 
	{
		super(0, 0);
		makeGraphic(width, height, 0x00000000, true);
	}
	
	override public function update():Void 
	{
		
		super.update();
	}
	
	/**
	 * Paints a vertical line of pixels of the desired color with variable length and alphe
	 * @param	x			start x
	 * @param	y			end y
	 */
	public function paint(x : Int , y : Int)
	{
		var rng : Int = Math.floor(Math.random() * 4);
		stamp(brushes[rng], x, y); 
	}
	
}