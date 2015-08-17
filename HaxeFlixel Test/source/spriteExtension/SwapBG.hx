package spriteExtension ;

import flixel.addons.display.FlxBackdrop;

/**
 * Same as bgsprite but can switch graphics
 */
class SwapBG extends FlxBackdrop implements SwapInterface
{
	private var graphicArray : Array<Dynamic>;
	
	public function new(x : Float, y : Float, graphicArray : Array<Dynamic>, xFactor : Float = 1) 
	{
		this.graphicArray = graphicArray;
		super(graphicArray[0], xFactor, 1, true, false);	
		this.x = x;
		this.y = y;
	}
	
	public function swapGraphics(index:Int) 
	{
		this.loadGraphic(graphicArray[index]);
	}
		
}