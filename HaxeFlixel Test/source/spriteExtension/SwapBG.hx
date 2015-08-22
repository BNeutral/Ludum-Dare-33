package spriteExtension ;

import flixel.addons.display.FlxBackdrop;
import flash.geom.Rectangle;
import flixel.FlxG;
import flixel.system.layer.Region;
import flixel.util.loaders.TextureRegion;
import openfl.display.BitmapData;
import openfl.geom.Point;

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
	
	/**
	 * Copy pasted code from the constructor because FlxBackdrop is badly coded
	 */
	public function swapGraphics(index:Int) 
	{		
		cachedGraphics = FlxG.bitmap.add(graphicArray[index]);
		
		if (!Std.is(graphicArray[index], TextureRegion))
		{
			region = new Region(0, 0, cachedGraphics.bitmap.width, cachedGraphics.bitmap.height);
			region.width = cachedGraphics.bitmap.width;
			region.height = cachedGraphics.bitmap.height;
		}
		else
		{
			region = cast(graphicArray[index], TextureRegion).region.clone();
		}
		
		var w:Int = region.width;
		var h:Int = region.height;
		
		if (_repeatX) 
		{
			w += FlxG.width;
		}
		if (_repeatY) 
		{
			h += FlxG.height;
		}
		
		#if FLX_RENDER_BLIT
		_data = new BitmapData(w, h);
		#end
		_ppoint = new Point();
		
		#if FLX_RENDER_TILE
		_tileInfo = [];
		_numTiles = 0;
		#else
		var regionRect:Rectangle = new Rectangle(region.startX, region.startY, region.width, region.height);
		#end
		
		while (_ppoint.y < h)
		{
			while (_ppoint.x < w)
			{
				#if FLX_RENDER_BLIT
				_data.copyPixels(cachedGraphics.bitmap, regionRect, _ppoint);
				#else
				_tileInfo.push(_ppoint.x);
				_tileInfo.push(_ppoint.y);
				_numTiles++;
				#end
				_ppoint.x += region.width;
			}
			_ppoint.x = 0;
			_ppoint.y += region.height;
		}
		
		updateFrameData();
	}
		
}