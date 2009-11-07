package com.baseoneonline.flash.geom
{
	

	public class Vec2f
	{
		
		public var x:Number;
		public var y:Number;
		
		public function Vec2f(x:Number=0, y:Number=0)
		{
			this.x = x;
			this.y = y;
		}
		
		/**
		 * Set this vector to 0.
		 * 
		 */
		public function zero():void {
			x = 0;
			y = 0;
		}
		
		/**
		 * Don't modify original.
		 *  
		 * @param v
		 * @return A new vector.
		 * 
		 */
		public function add(v:Vec2f):Vec2f {
			return new Vec2f(x+v.x, y+v.y);
		}
		
		/**
		 * Modifying original.
		 *  
		 * @param n
		 * @return This vector
		 * 
		 */
		public function addLocal(n:Vec2f):Vec2f {
			x += n.x;
			y += n.y;
			return this;
		}
		
		/**
		 * Don't modify original 
		 * @param v	A Vec2f or a Number
		 * @return A new Vector
		 * 
		 */
		public function mult(v:*):Vec2f {
			if (v is Vec2f)
				return new Vec2f(x*v.x, y*v.y);
			return new Vec2f(x*v, y*v);
		}
		
		/**
		 * Modify original 
		 * @param v	A Vec2f or a Number
		 * @return This vector
		 * 
		 */
		public function multLocal(v:*):Vec2f {
			if (v is Vec2f) {
				x *= v.x;
				y *= v.y;
			} else {
				x *= v;
				y *= v;
			}
			return this;
		}
		
		/**
		 * Don't modify original 
		 * @param v	A Vec2f or a Number
		 * @return A new vector.
		 * 
		 */
		public function divide(v:*):Vec2f {
			if (v is Vec2f)
				return new Vec2f(x/v.x, y/v.y);
			return new Vec2f(x/v, y/v);
		}
		
		/**
		 * Modify original 
		 * @param v	A Vec2f or a Number
		 * @return 
		 * 
		 */
		public function divideLocal(v:*):Vec2f {
			if (v is Vec2f) {
				x /= v.x;
				y /= v.y;
			} else {
				x /= v;
				y /= v;
			}
			return this;
		}
		
		public function distance(v:Vec2f):Number {
			var dx:Number = v.x - x;
			var dy:Number = v.y - y;
			return Math.sqrt(Math.pow(dx,2) + Math.pow(dy,2));
		}
		
		public function set(v:Vec2f):Vec2f {
			x = v.x;
			y = v.y;
			return this;
		}
		
		public function interpolate(v:Vec2f, p:Number):Vec2f {
			return new Vec2f(x + (v.x-x)*p, y+ (v.y-y)*p);
		}
		
		public function clone():Vec2f {
			return new Vec2f(x,y);
		}
		
		public function toString():String {
			return "[Vec2f x:"+x+", y:"+y+"]";
		}
		
	}
}