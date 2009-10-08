package com.baseoneonline.flash.astar
{
	import com.baseoneonline.flash.geom.Vec2i;

	public class TileNode extends Vec2i {
		
		public var index:int;
		public var cost:Number = 0;	
		
		function TileNode(x:int, y:int, index:int, cost:Number) {
			super(x,y);
			this.cost = cost;
			this.index = index;
		}
		
		public function walkable():Boolean {
			return cost != -1;
		}
		
	}
}