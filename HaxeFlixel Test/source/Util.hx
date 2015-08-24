package ;
import flixel.FlxSprite;
import flixel.util.FlxPoint;

/**
 * Utility functions
 */
class Util
{
	
	public static function toRadians(degrees : Float) : Float
	{
		return Math.PI / 180 * degrees;
	}
	
	public static function toDegrees(radians: Float) : Float
	{
		return radians * 180 / Math.PI;
	}
	
	public static function spriteDistance(spr1 : FlxSprite, spr2 : FlxSprite) : Float
	{
		var spr1CenterX : Float = spr1.x + spr1.width / 2;
		var spr1CenterY : Float = spr1.y + spr1.height / 2;
		var spr2CenterX : Float = spr2.x + spr2.width / 2;
		var spr2CenterY : Float = spr2.y + spr2.height / 2;
		var normX : Float = spr2CenterX - spr1CenterX;
		var normY : Float = spr2CenterY - spr1CenterY;
		return Math.sqrt(normX*normX + normY*normY);
	}
	
	public static function spriteCenterNormalizedSubstraction(spr1 : FlxSprite, spr2 : FlxSprite) : FlxPoint
	{
		var spr1CenterX : Float = spr1.x + spr1.width / 2;
		var spr1CenterY : Float = spr1.y + spr1.height / 2;
		var spr2CenterX : Float = spr2.x + spr2.width / 2;
		var spr2CenterY : Float = spr2.y + spr2.height / 2;
		
		var normX : Float = spr2CenterX - spr1CenterX;
		var normY : Float = spr2CenterY - spr1CenterY;
		var dist : Float = Math.sqrt(normX*normX + normY*normY);
		normX /= dist;
		normY /= dist;
		return new FlxPoint(normX, normY);
	}
}