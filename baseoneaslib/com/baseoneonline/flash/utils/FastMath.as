package com.baseoneonline.flash.utils
{
	public class FastMath
	{
	
		private static var SQRTLUT:Object;
		
		public static function createSQRTLUT():Object {
			var cache:Object = {};
			for(var i:int = 0; i < 10000; i++)
			{
				cache[i * i] = i;
			}
			return cache;
		}
		
		public static function sqrt(n:Number):Number {
			if (!SQRTLUT) SQRTLUT = createSQRTLUT();
			var x:int    = int(n);
			var y:int    = SQRTLUT[x];
			
			if(y * y == n)
			{
				return y;
			}
			
			var d:Number = n - x;
			var p:Number = d / (y << 2);
			var a:Number = y + p;
			
			return a - p * p / 2 * a;
		}
	}
}