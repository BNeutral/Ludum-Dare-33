package;

import flixel.util.FlxSave;

/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{
	public static var amountOfLevels : Int;
	public static var lastClearedLevel :Int = 0;
	public static var levelCompletition : Array<Int> = [];
	public static var levels:Array<String> = [];
	public static var levelSlimeTargets:Array<Int> = [];
	
	/**
	 * Generic bucket for storing different FlxSaves.
	 * Especially useful for setting up multiple save slots.
	 */
	public static var saves:Array<FlxSave> = [];
}