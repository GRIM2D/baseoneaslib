package
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	public class Marker extends Sprite
	{
		
		private var col:uint;
		private var lineWidth:Number = 2;
		private var size:Number = 8;
		
		public function Marker(color:uint = 0xFFFFFF)
		{
			this.col = color;
			redraw();
		}
		
		private function redraw():void {
			var g:Graphics = graphics;
			g.clear();
			g.lineStyle(lineWidth, col);
			g.moveTo(-size, 0);
			g.lineTo(size, 0);
			g.moveTo(0, -size);
			g.lineTo(0, size);
		}

	}
}