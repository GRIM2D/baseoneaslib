package
{
	import com.baseoneonline.flash.astar.IAStarSearchable;
	import com.baseoneonline.flash.geom.IntPoint;
	
	public class Tilemap implements IAStarSearchable
	{
		
		private var w:int;
		private var h:int;
		private var data:Array;
		
		public function Tilemap(w:int=30,h:int=30)
		{
			init(w,h);
		}
		
		public function init(w:int, h:int):void {
			this.w = w;
			this.h = h;
			data = new Array(w);
			for (var x:int=0; x<w; x++) {
				data[x] = new Array(h);
				for (var y:int=0; y<h; y++) {
					data[x][y] = new Tile(Math.random() > .1);
					trace(data[x][y].cost);
				}
			}
		}
		
		public function getTile(p:IntPoint):Tile {
			return data[p.x][p.y];
		}
		
		public function getWidth():int {
			return w;
		}
		
		public function getHeight():int {
			return h;
		}
		
		public function isWalkable(x:int, y:int):Boolean {
			return (data[x][y].cost != -1);
		}

	}
}

