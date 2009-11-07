package com.baseoneonline.flash.curves
{
	
	import com.baseoneonline.flash.geom.Vec2f;

	public class Bezier implements ICurve
	{
		
		public var pts:Vector.<Vec2f>;
		
		/**
		 * Constructs a Bezier curve, the number of points defines the degree of the curve.
		 * @param pts
		 * 
		 */
		public function Bezier(pts:Vector.<Vec2f>)
		{
			this.pts = pts;
		}
		
		public function getCV(i:int):Vec2f {
			return pts[i];
		}
		
		public function numCVs():int {
			return pts.length;
		}
		
		public function getPoint(time:Number, store:Vec2f=null):Vec2f {
			if (!store) store = new Vec2f();

			if (time <= 0) return pts[0];
			if (time >= 1) return pts[pts.length-1];
			
			var count:int, iCount:int, diff:int, blend:Number, tempVect:Vec2f;
			var muk:Number = 1;
			var munk:Number = Math.pow(1 - time, pts.length - 1);
			
			for (var i:int = 0; i < pts.length; i++) {
				count = pts.length - 1;
				iCount = i;
				diff = count - iCount;
				blend = muk * munk;
				muk *= time;
				munk /= (1 - time);
				while (count >= 1) {
					blend *= count;
					count--;
					if (iCount > 1) {
						blend /= iCount;
						iCount--;
					}
					
					if (diff > 1) {
						blend /= diff;
						diff--;
					}
				}
				tempVect = pts[i];
				store.addLocal(tempVect.mult(blend));
			}
			
			return store;
		}
		
		public function getLength(samples:int):Number {
			var n:Number = 0;
			var pp:Vec2f = getPoint(0);
			var p:Vec2f;
			for (var i:int=1; i<=samples; i++) {
				p = getPoint(i/samples);
				n += p.distance(pp);
				pp = p;
			}
			return n;
		}

	}
}