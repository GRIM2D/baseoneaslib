/*
Point3.as

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

	
	
	/**
	 * 
	 * 	Defines a 3 dimensional point.
	 * 
	 */
	public class Point3
	{
		
		public var x:Number;
		public var y:Number;
		public var z:Number;
		
		public function Point3(x:Number=0, y:Number=0, z:Number=0)
		{
			this.x = x;
			this.y = y;
			this.z = z;
		}
		
		public function set length(n:Number):void {
			// Sorry, read only.
		}
		
		public function get length():Number {
			return Math.sqrt(x*x+y*y+z*z);
		}
		
		public function add(v:Point3):Point3 {
			return new Point3(x+v.x, y+v.y, z+v.z);
		}
		
		public function clone():Point3 {
			return new Point3(x,y,z);
		}
		
		public function equals(p:Point3):Boolean {
			return p.x==x && p.y==y && p.z==z;
		}
		
		public static function interpolate(p1:Point3, p2:Point3, f:Number):Point3 {
			return new Point3(	p1.x+((p2.x-p1.x)*f),
								p1.y+((p2.y-p1.y)*f),
								p1.z+((p2.z-p1.z)*f));
		}
		

	}
}
