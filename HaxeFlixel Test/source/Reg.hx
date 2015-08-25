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
		if (index >= 0 && index < Reg.levelMusic.length) return levelMusic[index];
		else return "assets/music/Compressed/Stage 1 (Comp).mp3";
	}
	
	public static function getOwl(index : Int) : String
	{
		if (index >= 0 && index < Reg.owlMessages.length) return owlMessages[index];
		else return "Hoot~";
	}
	
	public static function getLevel(index : Int) : String
	{
		if (index >= 0 && index < Reg.levels.length) return levels[index];
		else return null;
	}
	
	public static function getSlimeNeeded(index : Int) : Int
	{
		if (index >= 0 && index < Reg.levelSlimeTargets.length) return levelSlimeTargets[index];
		else return 1;
	}

	public static var wonTheGame : Bool = false;
	
	public static var lastClearedLevel :Int = -1;
	
	//public static var levelCompletition : Array<Int> = [];
	
	public static var levels:Array<String> = [
			"assets/data/simplest01.tmx",
			"assets/data/01.tmx",
			"assets/data/02.tmx",
			"assets/data/03.tmx",
			"assets/data/04.tmx",
			"assets/data/05.tmx",
			"assets/data/06.tmx",
			"assets/data/Leap.tmx",
			"assets/data/Rused.tmx",
			"assets/data/Backtrack.tmx",
			"assets/data/PlantRun.tmx"
			];
	
	public static var levelMusic:Array<String> = [
			"assets/music/Compressed/Stage 1 (Comp).mp3",
			"assets/music/Compressed/Stage 1 (Comp).mp3",
			"assets/music/Compressed/Stage 1 (Comp).mp3",
			"assets/music/Compressed/Stage 1 (Comp).mp3",
			"assets/music/Compressed/Stage 2 (Comp).mp3",
			"assets/music/Compressed/Stage 2 (Comp).mp3",
			"assets/music/Compressed/Stage 2 (Comp).mp3",
			"assets/music/Compressed/Stage 2 (Comp).mp3",
			"assets/music/Compressed/Stage 3 (Comp).mp3",
			"assets/music/Compressed/Stage 3 (Comp).mp3",
			"assets/music/Compressed/Stage 4 (Comp).mp3"
			];
	
	public static var owlMessages:Array<String> = [
			"Hoot! Expanding your kingdom, are we? Your friends seem to be waiting... well, I don't mind if slime gets everywhere... Hoo!",
			"Hoot! Food can be found in the strangest places... you're looking a little hungry, but I'm not food!",
			"Hoot! Figuring out things for yourself, I see? Hoo Hoo! Being a slime must be nice...",
			"Hoot! We can miss things if we don't take the time to look around, hm?",
			"Hoot! Some plants would love to snack on a slime like yourself! No one gets through life without a little pain, hm?",
			"Hoot! Monsters sure love to share their things, don't they? But sometimes, you might just have to take! Aggressively take!",
			"Hoot! Everything the slime touches belongs to you, hm? But you don't want to touch those flowers? Well, I understand."];
			
	public static var levelSlimeTargets:Array<Int> = [
		12000, 16000, 12000, 20000, 16000, 4000, 4000, 30000, 20000, 20000, 1		
		];
	
	/**
	 * Generic bucket for storing different FlxSaves.
	 * Especially useful for setting up multiple save slots.
	 */
	public static var saves:Array<FlxSave> = [];
}