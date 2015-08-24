package characters;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;

class Owl extends FlxGroup
{

	/**
	 * 
	 * @param	X
	 * @param	Y
	 * @param	levelNumber
	 * @param	owlNumber		For different owls in the same level, currently not used
	 */
	public function new(X : Float, Y : Float, levelNumber : Int, owlNumber : Int) 
	{
		super();
		add(new FlxSprite(X, Y, "assets/images/owl/owl.png"));
		add(new FlxSprite(X - 24, Y - 160, "assets/images/owl/speechBubble.png"));
		var text : FlxText = new FlxText(X, Y - 120, 200, Reg.getOwl(levelNumber), 18, true);
		text.font = "assets/fonts/DJB Speak Softly.ttf";
		text.color = 0xFF000000;
		text.alignment = "center";
		add(text);
	}
	
}