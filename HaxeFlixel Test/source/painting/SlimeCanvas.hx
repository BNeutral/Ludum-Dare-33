package painting;
import flixel.FlxSprite;
import openfl.display.BitmapData

/**
 * Class to paint slime on stage tiles
 */
class SlimeCanvas extends FlxSprite
{
	private var data : BitmapData;

	public function new(width : Int, height : Int) 
	{
		data = new BitmapData(width, height, true, 0x00000000);
		super(0, 0, data);
	}
	
	/**
	 * Paints a vertical line of pixels of the desired color with variable length and alphe
	 * @param	x			start x
	 * @param	y			end y
	 * @param	color		color
	 * @param	maxStreak	max rng length
	 * @param	alphaMin	min rng alpha
	 * @param	alphaMax	max rng alpha
	 */
	public function paint(x : Int , y : Int, color : UInt, maxStreak : Int, alphaMin : Float, alphaMax : Float)
	{
		var max : Int = Math.round(Math.random()*(maxStreak)
		for (i in 0...max)
		{
			data.setPixel(x, y + i, color); 
		}
	}
	
}