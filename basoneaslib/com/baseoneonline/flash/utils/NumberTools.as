package com.baseoneonline.flash.utils
{
	public class NumberTools
	{
		
		public static function limit(n:Number, min:Number, max:Number):Number {
			if (n < min) n = min;
			if (n > max) n = max;
			return n;
		}
		
		public static function wrap(n:Number, min:Number, max:Number):Number {
			//trace(n+" : "+min+" : "+max);
			var d:Number = max-min;
			while (n > max) n -= d;
			while (n < min) n += d;
			return n;
		}
		
		public static function radToDeg(n:Number):Number {
			return n * 180/Math.PI;
		}
		
		public static function degToRad(n:Number):Number {
			return n * Math.PI/180;
		}
		
	}
}