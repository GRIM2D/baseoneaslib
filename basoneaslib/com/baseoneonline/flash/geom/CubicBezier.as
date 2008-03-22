/*

	IntPoint

	Copyright (c) 2008 B Korsmit

    This file is part of BaseOne Actionscript 3 Library.

    BaseOne Actionscript 3 Library is free software: you can
    redistribute it and/or modify it under the terms of the
    GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License,
    or any later version.

    BaseOne Actionscript 3 Library is distributed
    in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with BaseOne Actionscript 3 Library.  If not, see <http://www.gnu.org/licenses/>.
*/
package com.baseoneonline.flash.geom
{
	import flash.geom.Point;
	
	/**
	 * 	A bezier curve defined by four points.
	 * 
	 */
	public class CubicBezier
	{
		private var p1:Point;
		private var p2:Point;
		private var p3:Point;
		private var p4:Point;
		
		/**
		 * 	
		 * 	@param	p1	First endpoint
		 * 	@param	p2	First controlpoint
		 * 	@param	p3	Second controlpoint
		 * 	@param	p4	Second endpoint
		 */
		function CubicBezier(p1:Point, p2:Point, p3:Point, p4:Point)
		{
			this.p1 = p1;
			this.p2 = p2;
			this.p3 = p3;
			this.p4 = p4;
		}
		
		/**
		 * 	Returns a 2D point on the curve
		 * 
		 * 	@param	mu	Position on curve Value from 0 to 1
		 * 	@return	A curve point.
		 */
		public function getPoint(mu:Number):Point {
			if (mu<=0) return p1;
			if (mu>=1) return p4;
			var mum1:Number = 1-mu;
			var mum13:Number = mum1*mum1*mum1;
			var mu3:Number = mu*mu*mu;
			
			return new Point(	mum13*p1.x + 3*mu*mum1*mum1*p2.x + 3*mu*mu*mum1*p3.x + mu3*p4.x,
								mum13*p1.y + 3*mu*mum1*mum1*p2.y + 3*mu*mu*mum1*p3.y + mu3*p4.y	);
		}
	}
}