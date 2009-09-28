/*
AStar.as

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
	
	
	
	public class AStar
	{

		/**
		 * Width of the map to be searched 
		 */
		private var width:int;
		
		/**
		 * Height of the map to be searched 
		 */
		private var height:int;
		
		/**
		 * 	Out copy of the user's map.
		 */
		private var map:Array;
		
		/**
		 * 	The user's map, just keeping a reference
		 * 	in case the user wants to update.
		 */
		private var userMap:IAStarSearchable;
		
		/**
		 *	Nodes to be considered
		 */
		private var open:Array;
		
		/**
		 * 	Nodes not to consider anymore
		 */
		public var closed:Array;
		
		/**
		 * 	For debugging, can be omitted.
		 */
		public var visited:Array = [];
		
		/**
		 * 	Our distance function, for flexibility.
		 * 	Inline your favourite for speed.
		 */
		public var distanceFunction:Function = distManhattan;
		
		/**
		 * 	We're using a square map with diagonal movement,
		 * 	precalculate the relative cost of the diagonal move.
		 */
		private static const COST_ORTHOGONAL:Number = 1;
		private static const COST_DIAGONAL:Number = COST_ORTHOGONAL*Math.sqrt(2);
		
		
		/**
		 * 
		 * @param 	map		The map to be searched, will not be modified
		 * 
		 */
		function AStar(map:IAStarSearchable)
		{
			setMap(map);
		}
		
		/**
		 * 
		 * 	Set the map to be searched. The map will not be altered,
		 * 	an internal copy will be used to search it.
		 * 
		 */
		public function setMap(m:IAStarSearchable):void {
			userMap = m;
			updateMap();
		}
		
		/**
		 * 	Use if map has changed, reconstructs
		 * 	internal copy of the map.
		 */
		public function updateMap():void {
			width = userMap.getWidth();
			height = userMap.getHeight();
			map = new Array(width);
			for (var x:int=0; x<width; x++) {
				if (!map[x]) map[x] = new Array(height);
				for (var y:int=0; y<height; y++) {
					map[x][y] = new AStarNode(x,y, userMap.isWalkable(x,y));
				}
			}
		}
		
		
		/**
		 * 	Find the path!
		 * 
		 * 	@return	An array of IntPoints describing the resulting path
		 * 
		 */
		public function findPath(startPoint:IntPoint, goalPoint:IntPoint):Array
		{
			open = new Array();
			closed = new Array();
			visited = new Array();
			
			var start:AStarNode = map[startPoint.x][startPoint.y];
			var goal:AStarNode = map[goalPoint.x][goalPoint.y];
			
			open.push(start);
			start.g = 0;
			start.h = distanceFunction(start,goal);
			start.f = start.h;
			start.parent = null;			
			
			// Loop until there are no more nodes to search
			while(open.length > 0) {
				// Find lowest f in open
				var f:Number = Number.POSITIVE_INFINITY;
				var x:AStarNode;
				for (var i:int=0; i<open.length; i++) {
					if (open[i].f < f) {
						x = open[i];
						f = x.f;
					}
				}
				
				// Solution found, return solution
				if (x == goal) return reconstructPath(goal);
				
				// Close current node
				open.splice(open.indexOf(x),1);
				closed.push(x);
				
				for each (var y:AStarNode in neighbors(x)) {
					
					if (-1 != closed.indexOf(y))
						continue;
					
					var g:Number = x.g + y.travelCost;
					var better:Boolean = false;
					
					if (-1 == open.indexOf(y)) {
						open.push(y);
						visit(y); // DEBUG: REMOVE
						better = true;
					} else if (g < y.g) {
						better = true;
					}
					if (better) {
						y.parent = x;
						y.g = g;
						y.h = distanceFunction(y,goal);
						y.f = y.g + y.h;
					}
					
				}
				
			}
			// No solution found, return empty path
			var min:Number = Number.POSITIVE_INFINITY;
			var ng:AStarNode;
			for each(var n:AStarNode in closed) {
				var dist:Number = distanceFunction(goal, n);
				if (dist < min) {
					min = dist;
					ng = n;
				}
			}
			var altPath:Array = reconstructPath(ng);
			return reconstructPath(ng);
			return [];				
		}
		
		private function reconstructPath(n:AStarNode):Array {
			var solution:Array = [];
			var nn:AStarNode = n;
			while(nn.parent) {
				solution.push(new IntPoint(nn.x, nn.y));
				nn = nn.parent;
			}
			return solution;
		}
		
		/**
		 * 	For debug only, remove to gain performance	
		 */
		private function visit(n:AStarNode):void
		{
			for each(var node:AStarNode in visited) {
				if (node == n) return;
			}
			visited.push(n);
		}
		
		/**
		 * 	Faster, more inaccurate heuristic method
		 */
		public static function distManhattan(n1:AStarNode, n2:AStarNode):Number {
			return Math.abs(n1.x-n2.x)+Math.abs(n1.y-n2.y);
		}
		
		/**
		 * 	Slower but much better heuristic method. Actually,
		 * 	this returns just the distance between 2 points.
		 */
		public static function distEuclidian(n1:AStarNode, n2:AStarNode):Number {
			return Math.sqrt(Math.pow((n1.x-n2.x),2)+Math.pow((n1.y-n2.y),2));
		}
		
		
		/**
		 * 
		 * 	Return a node's neighbors, IF they're walkable
		 * 
		 * 	@return An array of AStarNodes.
		 */
		private function neighbors(node:AStarNode):Array
		{
			var x:int = node.x;
			var y:int = node.y;
			var n:AStarNode;
			var a:Array = new Array(8);
			
			
			// N
			if (x > 0) {
				
				n = map[x-1][y];
				if (n.walkable) {
					n.travelCost = COST_ORTHOGONAL;
					a.push(n);
				}
			}
			// E
			if (x < width-1) {
				n = map[x+1][y];
				if (n.walkable) {
					n.travelCost = COST_ORTHOGONAL;
					a.push(n);
				}
			} 
			// N
			if (y > 0) {
				n = map[x][y-1];
				if (n.walkable) {
					n.travelCost = COST_ORTHOGONAL;
					a.push(n);
				}
			}
			// S
			if (y < height-1) {
				n = map[x][y+1];
				if (n.walkable) {
					n.travelCost = COST_ORTHOGONAL;
					a.push(n);
				}
			}
			
			// Don't cut corners here,
			// but make diagonal travelling possible.
			
			// NW
			if (x > 0 && y > 0) {
				n = map[x-1][y-1];
				if (n.walkable 
					&& map[x-1][y].walkable 
					&& map[x][y-1].walkable
				) {						
					n.travelCost = COST_DIAGONAL;
					a.push(n);
				}
			}
			// NE
			if (x < width-1 && y > 0) {
				n = map[x+1][y-1];
				if (n.walkable 
					&& map[x+1][y].walkable 
					&& map[x][y-1].walkable
				) {
					n.travelCost = COST_DIAGONAL;
					a.push(n);
				}
			}
			// SW
			if (x > 0 && y < height-1) {
				n = map[x-1][y+1];
				if (n.walkable
					&& map[x-1][y].walkable 
					&& map[x][y+1].walkable
				) {
					n.travelCost = COST_DIAGONAL;
					a.push(n);
				}
			}
			// SE
			if (x < width-1 && y < height-1) {
				n = map[x+1][y+1];
				if (n.walkable
					&& map[x+1][y].walkable
					&& map[x][y+1].walkable
				) {
					n.travelCost = COST_DIAGONAL;
					a.push(n);
				}
			}
			
			
			return a;
			
		}
		
	}



}




