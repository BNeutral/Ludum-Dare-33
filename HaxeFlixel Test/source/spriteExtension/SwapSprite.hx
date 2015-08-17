package spriteExtension ;
import flixel.FlxSprite;

/**
 * A class that swaps into different sprites
 */
class SwapSprite extends FlxSprite implements SwapInterface
{
	private var graphicArray : Array<Dynamic>;
	
	public function new(x : Float, y : Float, graphicArray : Array<Dynamic>) 
	{
		this.graphicArray = graphicArray;
		super(x, y, graphicArray[0]);
	}
	
	public function swapGraphics(index:Int) 
	{
		this.loadGraphic(graphicArray[index]);
	}
	
}