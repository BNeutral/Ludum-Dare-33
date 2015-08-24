package states ;
import buttons.ClickableText;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flash.Lib;
import flash.net.URLRequest;
import flash.net.FileReference;
import flash.events.Event;

/**
 * Shows the credits
 */
class CreditsState extends FlxState
{
	private var texts : Array<FlxText> = new Array<FlxText>();
	
	private static inline var size : Int = 24;
	private static inline var spacing : Int = 40;
	
	override public function create():Void 
	{
		super.create();
		FlxG.mouse.visible = true;
		addText("BNeutral - Programming");
		addButton(" '- Twitter", "http://twitter.com/bneutral");
		addButton(" '- Tumblr", "http://bneutral.tumblr.com");
		addText("A_C - Additional programming");
		addText("...and moral support");
		addText("Gats - Art");
		addButton(" '- Twitter", "http://bneutral.tumblr.com");
		addText("Geistbox - Music");
		addButton(" '- Twitter", "https://twitter.com/geistbox");
		addButton(" '- Tumblr", "http://geistbox.tumblr.com/");
		addButton(" '- Bandcamp", "http://plumegeist.bandcamp.com/");
		addButton(" '- Soundcloud", "http://soundcloud.com/plumegeist");
		addText("John Doe - Level Design");
		addButton(" '- Tumblr (NSFW)", "http://johndoe-art.tumblr.com/");
		
		var exitButton : ClickableText = new ClickableText(function() { FlxG.switchState(new MenuState()); }, 12, FlxG.height - 32 , 100, "< Title (Esc)", size);
		add(exitButton);
		
		for (i in 0...texts.length)
		{
			FlxTween.linearMotion(texts[i], -FlxG.width, spacing * i, 0, spacing * i, 1, true, 
				{ type : FlxTween.ONESHOT, ease : FlxEase.backOut, startDelay : i*0.1} );
		}
	}
	
	/**
	 * Adds some text at the appropiate position
	 * @param	text
	 */
	private function addText(text : String) : Void
	{
		var text : FlxText = new FlxText(-FlxG.width, spacing * texts.length, FlxG.width, text, size);
		add(text);
		texts.push(text);
	}
	
	/**
	 * Adds some clickable text at the appropiate position that takes you to a url
	 * @param	text
	 */
	private function addButton(text : String, url : String) : Void
	{
		var button : ClickableText = new ClickableText(function(){ Lib.getURL(new URLRequest(url)); }, -FlxG.width, spacing * texts.length, 240, text, size);
		add(button);
		texts.push(button);
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (FlxG.keys.justPressed.F12)
		{
			fileCall();
		}
	}
	
	private function exit() : Void
	{
		if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(new MenuState());
	}
	
	private var file : FileReference;
	private function fileCall () : Void
	{
		file = new FileReference();
		file.browse();
		file.addEventListener(Event.SELECT, dialogueFileSelect);
	}
	
	private function dialogueFileSelect (event : Event) : Void 
	{
		file.addEventListener(Event.COMPLETE, dialogueLoadComplete);
		file.load();
	}

	private function dialogueLoadComplete (event : Event) : Void 
	{
		FlxG.switchState(new PlayState(-1, Xml.parse(file.data.toString())));
	}	
	
}