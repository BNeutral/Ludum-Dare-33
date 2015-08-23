package painting;

import flixel.FlxSprite;
import flash.display.BitmapData;

/**
 * Class to paint slime on stage tiles
 */
class SlimeCanvas extends FlxSprite
{
	private static var brush1 : FlxSprite;
	private static var brush2 : FlxSprite;
	private static var brush3 : FlxSprite;
	private static var brush4 : FlxSprite;
	private static var brush5 : FlxSprite;
	private static var brush6 : FlxSprite;
	private static var brushes : Array<FlxSprite>;
	
	public var paintedAmount : Int = 0;
	
	public function new(width : Int, height : Int) 
	{
		super(0, 0);
		makeGraphic(width, height, 0x00000000, true);
		
		brush1 = new FlxSprite(0, 0, "assets/images/splats/ASplat1.png");
		brush2 = new FlxSprite(0, 0, "assets/images/splats/ASplat2.png");
		brush3 = new FlxSprite(0, 0, "assets/images/splats/ASplat3.png");
		brush4 = new FlxSprite(0, 0, "assets/images/splats/ASplat4.png");
		brush5 = new FlxSprite(0, 0, "assets/images/splats/ASplat5.png");
		brush6 = new FlxSprite(0, 0, "assets/images/splats/ASplat6.png");
		brushes = [brush1, brush2, brush3, brush4, brush5, brush6];
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
		var rng : Int = Math.floor(Math.random() * brushes.length);
		
		var stroke : BitmapData = brushes[rng].get_pixels();
		var totalpx : Int = stroke.width * stroke.height;
		for (i in 0...totalpx)
		{
			if ((stroke.getPixel(i%stroke.width, cast(i / stroke.width,Int))) != 0
				&& ((this.cachedGraphics.bitmap.getPixel(x + i % stroke.width, cast(y + i / stroke.width,Int))) == 0))
			{
				++paintedAmount;
			}
		}		
		stamp(brushes[rng], x, y); 		
	}
	
}