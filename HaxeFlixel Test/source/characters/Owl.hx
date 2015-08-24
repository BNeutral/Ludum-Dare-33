package characters;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;

class Owl extends FlxGroup
{

	public function new(X : Float, Y : Float, levelNumber : Int, owlNumber : Int) 
	{
		super();
		add(new FlxSprite(X, Y, "assets/images/owl/owl.png"));
		add(new FlxSprite(X - 24, Y - 160, "assets/images/owl/speechBubble.png"));
		var text : FlxText = new FlxText(X, Y - 130, 200, "Hoot hoot, this is placeholder text. Three lines tops.", 24, true);
		text.font = "assets/fonts/DJB Speak Softly.ttf";
		text.color = 0xFF000000;
		text.alignment = "center";
		add(text);
	}
	
}