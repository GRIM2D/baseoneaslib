
package com.baseoneonline.flash.geom {
	import flash.geom.Point;
	
	/**
	 * 
	 * Shamelessly ripped from <a href="http://nccastaff.bournemouth.ac.uk/jmacey/RobTheBloke/www/opengl_programming.html"
	 * >http://nccastaff.bournemouth.ac.uk/jmacey/RobTheBloke/www/opengl_programming
	 * .html</a>
	 * 
	 * @author bask
	 * 
	 */
	public class NurbsCurve {
		
		
		private var pts:Array;
		private var degree:int;
		private var order:int;
		private var num_knots:int;
		private var maxKnotValue:Number;
		private var knots:Array;

		/**
		 * 
		 * @param pts	Array of Point objects
		 * @param degree
		 * 
		 */
		function NurbsCurve(pts:Array, degree:int=3) {
			this.pts = pts;
			setDegree(degree);
		}
		
		private function createKnots():void {
			knots = new Array(num_knots);
			var v:Number = 0;
			for (var i:int = 0; i < num_knots; i++) {
				knots[i] = v;
				if (i >= degree && i < num_knots - degree - 1) {
					v += 1;
				}
			}
			
			maxKnotValue = v;
		}
		
		public function getCV(i:int):Point {
			return pts[i];
		}
		
		public function setDegree(degree:Number):void {
			this.degree = degree;
			if (degree >= pts.length) degree = pts.length-1;
			order = degree + 1;
			num_knots = pts.length + order;
			createKnots();			
		}
		
		public function getPoint(t:Number, store:Point=null):Point {
			if (null == store) store = new Point();
			
			if (t <= 0) {
				store.x = pts[0].x;
				store.y = pts[0].y;
				return store;
			}
			if (t >= 1) {
				store.x = pts[pts.length-1].x;
				store.y = pts[pts.length-1].y;
				return store;
			}
			
			store.x = 0;
			store.y = 0;
			
			var valSum:Number = 0;
			var len:int = pts.length;
			for (var i:int = 0; i < len; i++) {
				var v:Number = coxDeBoor(t * maxKnotValue, i, degree);
				valSum += v;
				var p:Point = pts[i];
				store.x += p.x * v;
				store.y += p.y * v;
			}
			store.x /= valSum;
			store.y /= valSum;
			
			return store;
		}
		
		public function getAngle(t:Number, precision:Number = .00001):Number {
			var t1:Number = t;
			var t2:Number = t + precision;
			if (t2 > 1) {
				t1 = t - precision;
				t2 = t;
			}
			var p1:Point = getPoint(t1, null);
			var p2:Point = getPoint(t2, null);
			return Math.atan2(p2.y - p1.y, p2.x - p1.x);
		}
		
		private function coxDeBoor(t:Number, k:int, deg:int):Number {
			var b1:Number;
			var b2:Number;
			
			if (deg == 0) {
				if (knots[k] <= t && t <= knots[k + 1]) { return 1; }
				return 0;
			}
			
			if (knots[k + deg] != knots[k]) b1 = ((t - knots[k]) / (knots[k + deg] - knots[k]))
				* coxDeBoor(t, k, deg - 1);
			else
				b1 = 0;
			
			if (knots[k + deg + 1] != knots[k + 1]) b2 = ((knots[k + deg + 1] - t) / (knots[k
				+ deg + 1] - knots[k + 1]))
				* coxDeBoor(t, k + 1, deg - 1);
			else
				b2 = 0;
			
			return b1 + b2;
			
		}
		
		
		public function getNumCVs():int {
			return pts.length;
		}
		
	}
}