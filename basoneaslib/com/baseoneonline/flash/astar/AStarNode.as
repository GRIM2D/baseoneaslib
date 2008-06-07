/*
AStarNode.as

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
package com.baseoneonline.flash.astar
{
	import com.baseoneonline.flash.geom.IntPoint;
	
	/**
	 * 	Defines a weighted point/tile for use in AStar
	 * 
	 */
	public class AStarNode extends IntPoint
	{
		
		public var g:Number = 0;
		public var h:Number = 0;
		public var cost:Number = 1;
		
		// Needed to return a solution (trackback)
		public var parent:AStarNode;
		
		// Taken from the original tile
		public var walkable:Boolean;
		
		function AStarNode(x:int, y:int, walkable:Boolean=true)
		{
			super(x,y);
			this.walkable = walkable;
		}
		
		public function get f():Number {
			return g+h;
		}
				
	
	}
}
