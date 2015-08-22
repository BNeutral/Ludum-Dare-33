package buttons ;
import flixel.text.FlxText;

class TextWithCallback extends FlxText
{
	public var callback : Void->Void;
	
	public function new(callback : Void->Void, X:Float = 0, Y:Float = 0, FieldWidth:Float = 0, ?Text:String, Size:Int = 8, EmbeddedFont:Bool = true) 
	{
		this.callback = callback;
		super(X, Y, FieldWidth, Text, Size, EmbeddedFont);
	}
	
}