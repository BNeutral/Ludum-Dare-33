package buttons;
import flixel.FlxG;
import flixel.util.FlxPoint;

/**
 * Basically a button
 */
class ClickableText extends TextWithCallback
{
	private var screenPoint : FlxPoint = new FlxPoint();
	
	public function new(callback:Void->Void, X:Float=0, Y:Float=0, FieldWidth:Float=0, ?Text:String, Size:Int=8, EmbeddedFont:Bool=true) 
	{
		super(callback, X, Y, FieldWidth, Text, Size, EmbeddedFont);
		
	}
	
	override public function update():Void 
	{
		super.update();
		this.getScreenXY(screenPoint, FlxG.camera);
		if (FlxG.mouse.screenX > screenPoint.x &&  FlxG.mouse.screenX < (screenPoint.x + width) 
			&& FlxG.mouse.screenY > screenPoint.y &&  FlxG.mouse.screenY < (screenPoint.y + height))
		{
			this.color = 0xFF0000FF;
			if (FlxG.mouse.justPressed)
			{
				callback();
			}
		}
		else
		{
			this.color = 0xFFA0A0FF;
		}
	}
	
}