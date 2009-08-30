package
{
	import flash.display.Graphics;
	import flash.display.Shape;
	
	import mx.core.UIComponent;
	
	public class Corner extends UIComponent
	{
		
		private var size:Number = 24;
		private var shape:Shape = new Shape();
		private var lineColor:uint = 0xFFFFFF;
		private var lineWidth:Number = 4;
		
		public function Corner()
		{
			addChild(shape);
			redraw();
		}
		
		[Bindable]
		public function set cornerSize(n:Number):void {
			this.size = n;
			redraw();
		}
		
		public function get cornerSize():Number {
			return size;	
		}
		
		private function redraw():void {
			var g:Graphics = shape.graphics;
			var w:Number = unscaledWidth;
			var h:Number = unscaledHeight;
			g.clear();
			g.lineStyle(lineWidth*2, lineColor, 1, false);
			// Top Left
			g.moveTo(0,size);
			g.lineTo(0,0);
			g.lineTo(size, 0);
			// Top Right
			g.moveTo(w-size, 0);
			g.lineTo(w, 0);
			g.lineTo(w, size);
			// Bottom Left
			g.moveTo(0,h-size);
			g.lineTo(0,h);
			g.lineTo(size,h);
			// Bottom Right
			g.moveTo(w-size, h);
			g.lineTo(w,h);
			g.lineTo(w,h-size);
			
		}
		
		override protected function updateDisplayList(w:Number, h:Number):void {
			redraw();
		}

	}
}