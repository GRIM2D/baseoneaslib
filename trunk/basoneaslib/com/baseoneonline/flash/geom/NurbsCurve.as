/*
NurbsCurve.as

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

	public class NurbsCurve implements ICurve
	{
		
		
		private var points:Array;
		private var knots:Array;
		
		private var degree:int;
		private var order:int;
		
		public function NurbsCurve(pts:Array)
		{
			points = pts;
			setDegree(3);
		}
		
		
		public function setDegree(d:int):void {
			if (d+1 >= points.length) d = points.length-1;
			degree = d;
			calculateKnots();
		}
		
		
		
		/**
		 * 	I made it, but i don't know how it works anymore. (But it works)
		 * 
		 */
		private function calculateKnots():void {
			order = degree+1;
			knots = new Array(points.length+order);
			var div:Number = 0;
			var d:int = points.length-order;
			var w:Number = 0;
			if (d != 0) div = d+1;
			for (var i:int=0; i<knots.length; i++) {
				if (i>degree && i < knots.length-degree) w+=1;
				if (d != 0) knots[i] = w/div;
				else knots[i] = w;
			}
		}

		
		/**
		 * 
		 * @param mu	Position on the curve [0-1]
		 * @return 		A 2d point on the curve
		 * 
		 */
		public function getPoint(mu:Number):Point
		{
			if (mu <= 0) return points[0];
			if (mu >= 1) return points[points.length-1];
			
			var p:Point = new Point();
			var tp:Point = new Point();
			for (var i:int=0; i<points.length; i++) {
				tp = points[i];
				var blend:Number = coxDeBoor(mu, i, order);
				p.x += tp.x * blend;
				p.y += tp.y * blend;
			}
			
			return p;
		}
		
		
		public function coxDeBoor(u:Number, i:int, k:int):Number {
			if (k == 1) {
				if (knots[i] <= u && u <= knots[i+1]) return 1;
				return 0;
			}
			var d1:Number = knots[i+k-1]-knots[i];
			var d2:Number = knots[i+k]-knots[i+1];
			var e1:Number = 0;
			var e2:Number = 0;
			if (d1>0) e1 = ((u-knots[i])/d1)*coxDeBoor(u,i,k-1);
			if (d2>0) e2 = (knots[i+k]-u)/d2*coxDeBoor(u,i+1,k-1);
			return e1+e2;
		}
		
		public function getOffsetPoint(mu:Number, offset:Number):Point
		{
			return null;
		}
		
	}
}
