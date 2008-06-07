/*
IntPoint.as

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
	 * 	Simple integer point implementation
	 * 	
	 * 
	 */
	public class IntPoint
	{
		
		public var x:int;
		public var y:int;
		
		function IntPoint(x:int=0, y:int=0)
		{
			this.x = x;
			this.y = y;
		}
		
		
		public function add(p:IntPoint):void
		{
			x += p.x;
			y += p.y;
		}
		
		public function addNew(p:IntPoint):IntPoint {
			return new IntPoint(x+p.x, y+p.y);
		}
		

		public function toString():String
		{
			return "IntPoint("+x+", "+y+")";
		}
				
	}
}
