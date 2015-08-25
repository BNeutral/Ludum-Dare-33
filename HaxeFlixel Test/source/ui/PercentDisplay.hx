package ui ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import painting.SlimeCanvas;

class PercentDisplay extends FlxGroup
{
	private var firstNum : FlxSprite;
	private var secondNum : FlxSprite;
	private var thirdNum : FlxSprite;
	
	private var requiredPaint : Int = 0;
	public var currentNumber : Int = 0;
	private var slimeCanvas : SlimeCanvas;
	private var playedSound : Bool = false;

	private static var route : String = "assets/images/numbers/";
	private static var strNUmbers : Array<String> = ["0.png", "1.png", "2.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png"];
	
	public function new(requiredPaint : Int, slimeCanvas : SlimeCanvas) 
	{
		super();
		this.requiredPaint = requiredPaint;
		this.slimeCanvas = slimeCanvas;
		firstNum = new FlxSprite(0, 0, route+strNUmbers[0]);
		add(firstNum);
		secondNum = new FlxSprite(firstNum.x + firstNum.width, 0, route+strNUmbers[0]);
		add(secondNum);
		thirdNum = new FlxSprite(secondNum.x + secondNum.width, 0, route+strNUmbers[0]);
		add(thirdNum);
		var sign : FlxSprite= new FlxSprite(thirdNum.x + thirdNum.width, 0, route+"%.png");
		add(sign);
		var bucket : FlxSprite = new FlxSprite(sign.x + sign.width, 0, route+"bucket.png");
		add(bucket);
		
		currentNumber = 0;
		
		firstNum.scrollFactor.x = firstNum.scrollFactor.y = 0;
		secondNum.scrollFactor.x = secondNum.scrollFactor.y = 0;
		thirdNum.scrollFactor.x = thirdNum.scrollFactor.y = 0;
		sign.scrollFactor.x = sign.scrollFactor.y = 0;
		bucket.scrollFactor.x = bucket.scrollFactor.y = 0;
		
		firstNum.solid = secondNum.solid = thirdNum.solid = sign.solid = bucket.solid = false;
	}
	
	override public function update():Void 
	{
		super.update();
		var actualNumber : Int = Math.round((slimeCanvas.paintedAmount / requiredPaint) * 100);
		if (actualNumber >= 100) 
		{
			actualNumber = 100;
			if (!playedSound)
			{
				FlxG.sound.play("assets/sounds/100%.mp3");
				playedSound = true;
			}
		}
		if (actualNumber != currentNumber)
		{
			currentNumber = actualNumber;
			var first : Int = cast((actualNumber / 100),Int) % 10;
			var second : Int = cast((actualNumber / 10),Int) % 10;
			var third : Int = actualNumber % 10;
			firstNum.loadGraphic(route+strNUmbers[first]);
			secondNum.loadGraphic(route+strNUmbers[second]);
			thirdNum.loadGraphic(route+strNUmbers[third]);
		}
	}
	
}