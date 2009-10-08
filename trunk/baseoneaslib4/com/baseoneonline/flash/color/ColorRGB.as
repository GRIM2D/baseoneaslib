package com.baseoneonline.flash.color
{
	import com.baseoneonline.flash.utils.NumberTools;
	
	public class ColorRGB
	{
		
		public var r:Number;
		public var g:Number;
		public var b:Number;
		
		/**
		 * Create a new color, default is red (1,0,0);
		 */
		function ColorRGB(r:Number=1, g:Number=0, b:Number=0) {
			this.r = r;
			this.g = g;
			this.b = b;
		}
		
		/**
		 * 	Set this color's values from an uint(hex) number.
		 */
		public function fromHex(input:uint):void {
			
		}
		
		/**
		 * 	Return the uint(hex) value of this color.
		 */
		public function toHex():uint {
			return int(r*0xFF) << 16 | int(g*0xFF) << 8 | int(b*0xFF);
		}
		
		/**
		 * 	Return the uint(hex) value of a color.
		 * 	Channel values will be clamped (0-1).
		 */
		public static function rgbToHex(r:Number, g:Number, b:Number):uint {
			return 	int(NumberTools.limit(r)*0xFF) << 16 | 
					int(NumberTools.limit(g)*0xFF) << 8 | 
					int(NumberTools.limit(b)*0xFF);
		}
		
		/**
		 * 	Convert this uint color to an ColorRGB object, representing this
		 *  color's channels separately.	
		 */
		public static function hexToRGB(input:uint):ColorRGB {
			var r:Number = input >> 16 & 0xFF;
			var g:Number = input >> 8 & 0xFF;
			var b:Number = input & 0xFF;
			return new ColorRGB(r,g,b);		
		}
		
		/**
		 * 	Randomize this color a bit
		 * 
		 * 	@param dev 		A value of 1 will certainly generate a totally random color.
		 * 	@param multiply	If set to true, colors will be randomized to black (for darker variations).
		 */
		public function randomize(dev:Number=.1, multiply:Boolean=false):void {
			
			r += (Math.random()*dev*2)-dev;
			g += (Math.random()*dev*2)-dev;
			b += (Math.random()*dev*2)-dev;
			
			if (multiply) {
				var mul:Number = Math.random();
				r *= mul;
				g *= mul;
				b *= mul;
			}
		}
		
		/**
		 * 	@return A copy of this object.
		 */
		public function clone():ColorRGB {
			return new ColorRGB(r,g,b);
		}
	}
}