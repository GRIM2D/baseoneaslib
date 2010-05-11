/*
CubicBezier.as

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
package com.baseoneonline.flash.geom
{
	import flash.geom.Point;
	
	/**
	 * 	A bezier curve defined by four points.
	 * 
	 */
	public class CubicBezier implements ICurve
	{

		private var cv:Array;
		
		/**
		 * 	
		 * 	@param	p1	First endpoint
		 * 	@param	p2	First controlpoint
		 * 	@param	p3	Second controlpoint
		 * 	@param	p4	Second endpoint
		 */
		function CubicBezier(p1:Point, p2:Point, p3:Point, p4:Point)
		{
			cv = [p1, p2, p3, p4];
		}
		
		/**
		 * 	Returns a 2D point on the curve
		 * 
		 * 	@param	mu	Position on curve Value from 0 to 1
		 * 	@return	A curve point.
		 */
		public function getPoint(mu:Number, store:Point=null):Point {
			if (!store) store = new Point();
			if (mu<=0) return cv[0];
			if (mu>=1) return cv[3];
			var mum1:Number = 1-mu;
			var mum13:Number = mum1*mum1*mum1;
			var mu3:Number = mu*mu*mu;
			
			store.x = mum13*cv[0].x + 3*mu*mum1*mum1*cv[1].x + 3*mu*mu*mum1*cv[2].x + mu3*cv[3].x;
			store.y = mum13*cv[0].y + 3*mu*mum1*mum1*cv[1].y + 3*mu*mu*mum1*cv[2].y + mu3*cv[3].y;
			return store;
		}
		
		public function getPointAngle(mu:Number):Point {
			if (mu<=0) return cv[0];
			if (mu>=1) return cv[3];
			
			
			
			var m1:Point = Point.interpolate(cv[1],cv[0],mu);
			var m2:Point = Point.interpolate(cv[2],cv[1],mu);
			var m3:Point = Point.interpolate(cv[3],cv[2],mu);
			
			var q1:Point = Point.interpolate(m2,m1,mu);
			var q2:Point = Point.interpolate(m3,m2,mu);
			
			var pa:Point = new Point(q2.x-q1.x, q2.y -q1.y);
			
			
			var a:Number = Math.atan2(pa.y, pa.x);
			
			var p:Point = Point.interpolate(q2,q1,mu);
			return p;
		}
		
		public function getOffsetPoint(mu:Number, offset:Number):Point {
			if (mu<=0) mu=0;
			if (mu>=1) mu=1;
			
			
			
			var m1:Point = Point.interpolate(cv[1],cv[0],mu);
			var m2:Point = Point.interpolate(cv[2],cv[1],mu);
			var m3:Point = Point.interpolate(cv[3],cv[2],mu);
			
			var q1:Point = Point.interpolate(m2,m1,mu);
			var q2:Point = Point.interpolate(m3,m2,mu);
			
			var pa:Point = new Point(q2.x-q1.x, q2.y -q1.y);
			
			
			var a:Number = -Math.atan2(pa.y, pa.x);
			
			
			var p:Point = Point.interpolate(q2,q1,mu);
			
			var pp:Point = new Point(p.x+Math.sin(a)*offset, p.y+Math.cos(a)*offset);
			
			return pp;
		}
		
		public function getCV(i:int):Point {
			return cv[i];
		}
		
		public function getCVCount():int {
			return 4;
		}
		
	}
}
