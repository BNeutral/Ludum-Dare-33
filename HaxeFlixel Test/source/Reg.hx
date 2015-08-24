package;

import flixel.util.FlxSave;

/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{
	public static function getMusic(index : Int) : String
	{
		if (index >= 0 && index < Reg.levelMusic.length - 1) return levelMusic[index];
		else return "assets/music/Compressed/Stage 1 (Comp).mp3";
	}
	
	public static function getOwl(index : Int) : String
	{
		if (index >= 0 && index < Reg.owlMessages.length - 1) return owlMessages[index];
		else return "Hoot~";
	}
	
	public static function getLevel(index : Int) : String
	{
		if (index >= 0 && index < Reg.levels.length - 1) return levels[index];
		else return null;
	}
	
	public static function getSlimeNeeded(index : Int) : Int
	{
		if (index >= 0 && index < Reg.levelSlimeTargets.length - 1) return levelSlimeTargets[index];
		else return 40000;
	}

	public static var wonTheGame : Bool = false;
	
	public static var lastClearedLevel :Int = 0;
	
	public static var levelCompletition : Array<Int> = [];
	
	public static var levels:Array<String> = [
			
			];
	
	public static var levelMusic:Array<String> = [
			"assets/music/Compressed/Stage 1 (Comp).mp3",
			"assets/music/Compressed/Stage 2 (Comp).mp3",
			"assets/music/Compressed/Stage 3 (Comp).mp3",
			"assets/music/Compressed/Stage 4 (Comp).mp3"
			];
	
	public static var owlMessages:Array<String> = [
			"Hoot! Expanding your kingdom? Slimes must absorb, lest they grow too small...!",
			"Hoot! The bigger they are, the slower... is that how it goes?",
			"Hoot! Smaller monsters can't jump as much as bigger ones, hm!",
			"Hoot! Some plants would love to snack on a slime... like yourself!",
			"Hoot! The solution might have been stuck to you the whole time!, hm?",
			"Hoot! Monsters sure love to share their things, don't they?"];
			
	public static var levelSlimeTargets:Array<Int> = [
		
		];
	
	/**
	 * Generic bucket for storing different FlxSaves.
	 * Especially useful for setting up multiple save slots.
	 */
	public static var saves:Array<FlxSave> = [];
}