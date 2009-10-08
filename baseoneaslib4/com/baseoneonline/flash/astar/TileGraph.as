package com.baseoneonline.flash.astar
{
	
	
	
	
	

	public class TileGraph implements Graph
	{
		
		
		private var data:Vector.<Vector.<TileNode>>;
		private var nodes:Vector.<TileNode> = new Vector.<TileNode>(0,true);
		private var w:int;
		private var h:int;
		
		private static const COST_DIAG:Number = Math.sqrt(2);
		
		public function TileGraph(w:int=40, h:int=40)
		{
			init(w,h);
		}
		
		public function init(w:int, h:int):void {
			this.w = w;
			this.h = h;
			data = new Vector.<Vector.<TileNode>>(w, true);
			nodes = new Vector.<TileNode>(w*h, true);
			var i:int=0;
			for (var x:int=0; x<w; x++) {
				data[x] = new Vector.<TileNode>(h, true);
				for (var y:int=0; y<h; y++) {
					data[x][y] = new TileNode(x,y,i, 0);
					nodes[i] = data[x][y];
					i++;
				}
			}
		}
		
		public function getTile(index:int):TileNode {
			return nodes[index];
		}
		
		public function isWalkable(x:int, y:int):Boolean {
			return data[x][y].cost != -1;
		}
		
		public function getWidth():int {
			return w;
		}
		
		public function getHeight():int {
			return h;
		}
		
		public function distance(a:int, b:int):Number {
			var n1:TileNode = nodes[a];
			var n2:TileNode = nodes[b];
			var h_diag:Number = Math.min(Math.abs(n1.x - n2.x), Math.abs(n1.y - n2.y));
			var h_orth:Number = (Math.abs(n1.x - n2.x) + Math.abs(n1.y - n2.y));
			return COST_DIAG * h_diag + h_orth - 2 * h_diag;
		}
		
		public function getNodes(a:Vector.<int>):Vector.<TileNode> {
			var n:Vector.<TileNode> = new Vector.<TileNode>();
			for (var i:int=0; i<a.length; i++) {
				n[i] = this.nodes[a[i]];
			}
			return n;
		}
		
		public function clear():void {
			init(w,h);
		}
		
		public function getTileAt(x:int, y:int):TileNode {
			return data[x][y];
		}
		
		public function size():int {
			return nodes.length;
		}
		
		public function getNeighbors(node:int):Vector.<int> {
			var x:int = nodes[node].x;
			var y:int = nodes[node].y;
			var neighbors:Vector.<int> = new Vector.<int>();
			var n:TileNode;
			if (x > 0) {
				n = data[x - 1][y];
				if (n.walkable())
					neighbors.push(n.index);
			}
			if (y > 0) {
				n = data[x][y - 1];
				if (n.walkable())
					neighbors.push(n.index);
			}
			if (x < w - 1) {
				n = data[x + 1][y];
				if (n.walkable())
					neighbors.push(n.index);
			}
			if (y < h - 1) {
				n = data[x][y + 1];
				if (n.walkable())
					neighbors.push(n.index);
			}
			
			// Diagonal, no cutting corners
			// NW
			if (x > 0 && y > 0) {
				n = data[x - 1][y - 1];
				if (n.walkable() && data[x - 1][y].walkable()
					&& data[x][y - 1].walkable()) {
					neighbors.push(n.index);
				}
			}
			// NE
			if (x < w - 1 && y > 0) {
				n = data[x + 1][y - 1];
				if (n.walkable() && data[x + 1][y].walkable()
					&& data[x][y - 1].walkable()) {
					neighbors.push(n.index);
				}
			}
			// SW
			if (x > 0 && y < h - 1) {
				n = data[x - 1][y + 1];
				if (n.walkable() && data[x - 1][y].walkable()
					&& data[x][y + 1].walkable()) {
					neighbors.push(n.index);
				}
			}
			// SE
			if (x < w - 1 && y < h - 1) {
				n = data[x + 1][y + 1];
				if (n.walkable() && data[x + 1][y].walkable()
					&& data[x][y + 1].walkable()) {
					neighbors.push(n.index);
				}
			}
			
			return neighbors;
		}
		
	}
}