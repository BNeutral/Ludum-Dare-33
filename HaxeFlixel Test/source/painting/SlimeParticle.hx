package painting;
import flixel.effects.particles.FlxParticle;
import flixel.FlxG;
import flixel.tile.FlxTilemap;

/**
 * Slime particle
 */
class SlimeParticle extends FlxParticle
{
	private var canvas : SlimeCanvas;
	private var tiles : FlxTilemap;

	public function new(canvas : SlimeCanvas, tiles : FlxTilemap) 
	{
		super();
		this.canvas = canvas;
		this.tiles = tiles;
	}
	
	override public function onEmit():Void 
	{
		super.onEmit();
		
	}
	
	override public function update():Void 
	{
		super.update();
		FlxG.collide(this, tiles, paint);
	}
	
	private function paint(obj1 : FlxParticle, obj2 : FlxTilemap)
	{
		canvas.paint(cast(x - 5, Int) , cast(y, Int));
		kill();
	}
	
}