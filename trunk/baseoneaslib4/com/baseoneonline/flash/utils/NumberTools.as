/*
NumberTools.as

	Copyright (c) 2008 Bas Korsmit

    This file is part of baseone_flashLib

    baseone_flashLib is free software: you can
    redistribute it and/or modify it under the terms of the
    GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License,
    or any later version.

    baseone_flashLib Library is distributed
    in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with baseone_flashLib  If not, see <http://www.gnu.org/licenses/>.
*/
package com.baseoneonline.flash.utils
{
	public class NumberTools
	{
		
		/**
		 * 	Radians to degrees,
		 * 	multiply to convert.
		 */
		public static const RAD_TO_DEG:Number = 180/Math.PI;
		
		/**
		 * 	Degrees to radians,
		 * 	multply to convert.
		 */
		public static const DEG_TO_RAD:Number = Math.PI/180; 
		
		/**
		 * Keep a number between the limits. (Clamp)
		 */
		public static function limit(n:Number, min:Number=0, max:Number=1):Number {
			if (n < min) n = min;
			if (n > max) n = max;
			return n;
		}
		
		/**
		 * 	Keep a number within the limits, but keep the remainder as offset.
		 */
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
		
		/**
		 * Return a random number between the limits.
		 */
		public static function randRange(min:Number, max:Number):Number {
			return min+((max-min)*Math.random());
		}
		
	}
}
