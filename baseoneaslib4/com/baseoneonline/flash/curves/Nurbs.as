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
package com.baseoneonline.flash.curves
{
	import com.baseoneonline.flash.geom.Vec2f;

	public class Nurbs implements ICurve {
		
		private var pts:Vector.<Vec2f>;
		private var degree:int;
		private var order:int;
		private var num_knots:int;
		private var knots:Vector.<Number>;
		private var maxKnotValue:Number;
		
		function Nurbs(pts:Vector.<Vec2f>, degree:int=3) {
			this.pts = pts;
			this.degree = degree;
			order = degree + 1;
			num_knots = pts.length + order;
			createKnots();
		}
		
		private function createKnots():void {
			knots = new Vector.<Number>(num_knots, true);
			var v:Number = 0;
			for (var i:int = 0; i < num_knots; i++) {
				knots[i] = v;
				if (i >= degree && i < num_knots - degree - 1) {
					v += 1;
				}
			}
			maxKnotValue = v;
		}
		
		public function getCV(i:int):Vec2f {
			return pts[i];
		}
		
		public function getPoint(t:Number, store:Vec2f=null):Vec2f {
			if (!store) store = new Vec2f();
			
			if (t <= 0)
				return store.set(pts[0]);
			if (t >= 1)
				return store.set(pts[pts.length - 1]);
			
			store.zero();
			var valSum:Number = 0;
			var len:Number = pts.length;
			for (var i:int = 0; i < len; i++) {
				var v:Number = coxDeBoor(t * maxKnotValue, i, degree);
				valSum += v;
				var p:Vec2f = pts[i];
				store.addLocal(p.mult(v));
			}
			store.divideLocal(valSum);

			return store;
		}
		
		private function coxDeBoor(t:Number, k:int, deg:int):Number {
			var B1:Number;
			var B2:Number;
			
			if (deg == 0) {
				if (knots[k] <= t && t <= knots[k + 1]) {
					return 1.0;
				}
				return 0.0;
			}
			
			if (knots[k + deg] != knots[k]) 
				B1 = ((t - knots[k]) / (knots[k + deg] - knots[k]))
					* coxDeBoor(t, k, deg - 1);
			else
				B1 = 0.0;
			
			if (knots[k + deg + 1] != knots[k + 1])
				B2 = ((knots[k + deg + 1] - t) / (knots[k + deg + 1] - knots[k + 1]))
					* coxDeBoor(t, k + 1, deg - 1);
			else
				B2 = 0.0;
			
			return B1 + B2;
			
		}
		
		public function getLength(samples:int):Number {
			var n:Number = 0;
			var pp:Vec2f = getPoint(0);
			var p:Vec2f = new Vec2f();
			for (var i:int=1; i<=samples; i++) {
				getPoint(i/samples,p);
				n += p.distance(pp);
				pp = p;
			}
			return n;
		}
		
		public function numCVs():int {
			return pts.length;
		}
		
	}
}
