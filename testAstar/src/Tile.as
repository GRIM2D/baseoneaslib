package
{
	public class Tile {
		public var cost:Number = 0;	
		
		function Tile(walkable:Boolean=true, cost:Number=0) {
			this.cost = walkable ? cost : -1;
		}
		
}
}