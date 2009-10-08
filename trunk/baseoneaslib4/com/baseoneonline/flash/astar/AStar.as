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
	
	
	
	
	public class AStar
	{
		
		private var graph:Graph;
		
		private var g:Vector.<Number>;
		private var h:Vector.<Number>;
		private var f:Vector.<Number>;
		private var parent:Vector.<int>;
		
		private var open:Vector.<int>;
		private var closed:Vector.<int>;
		
		public function AStar(g:Graph) {
			setGraph(g);
		}
		
		public function setGraph(graph:Graph):void {
			this.graph = graph;
			updateGraph();
		}
		
		private function updateGraph():void {
			var len:int = graph.size();
			// Fixed length vectors
			g = new Vector.<Number>(len, true);
			h = new Vector.<Number>(len, true);
			f = new Vector.<Number>(len, true);
			parent = new Vector.<int>(len, true);
		}
		
		public function solve(start:int, goal:int):Vector.<int> {
			open = new Vector.<int>();
			closed = new Vector.<int>();
			
			open.push(start);
			
			g[start] = 0;
			h[start] = graph.distance(start, goal);
			f[start] = h[start];
			parent[start] = -1;
			
			while(open.length > 0) {
				
				// Find node with lowest f
				var tf:Number = Number.POSITIVE_INFINITY;
				var x:int = -1;
				for (var i:int=0; i<open.length; i++) {
					var e:int = open[i];
					if (f[e] < tf) {
						tf = f[e];
						x = e;
					}
				}
				
				if (x == goal) return createPath(goal);
				
				open.splice(open.indexOf(x), 1);
				closed.push(x);
				
				for each(var y:int in graph.getNeighbors(x)) {
					
					if (closed.indexOf(y) != -1) continue;
					
					var tg:Number = g[x] + graph.distance(x,y);
					var better:Boolean = false;
					
					if (open.indexOf(y) == -1) {
						open.push(y);
						better = true;
					} else if (tg < g[y]) {
						better = true;
					}
					if (better) {
						parent[y] = x;
						g[y] = tg;
						h[y] = graph.distance(y,goal);
						f[y] = g[y] + h[y];
					}
				}
			}
			
			// No solution found, return shortest alternative
			var min:Number = Number.POSITIVE_INFINITY;
			var ng:int = -1;
			for each(var n:int in closed) {
				var d:Number = graph.distance(goal, n);
				if (d < min) {
					min = d;
					ng = n;
				}
			}
			return createPath(ng);
			
		}
		
		private function createPath(n:int):Vector.<int> {
			var solution:Vector.<int> = new Vector.<int>();
			while (parent[n] != -1) {
				solution.push(n);
				n = parent[n];
			}
			return solution;
		}
		
		
	}


}




