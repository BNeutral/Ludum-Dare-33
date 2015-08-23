package ;

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
	
}