package
{
	import com.baseoneonline.flash.geom.NurbsCurve;
	
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	

	[SWF(width=450, height=300, frameRate=60, backgroundColor=0x303030)]
	public class TestNurbsCurve extends Sprite
	{
		
		private var curve:NurbsCurve;
		private var curveShape:Shape = new Shape();
		private var currentHandle:Handle;
		private var samples:int = 32;
		private var cageVisible:Boolean = true;
		
		private var tfStatus:TextField = new TextField();
		private var tfHelp:TextField = new TextField();
		
		
		
		public function TestNurbsCurve()
		{
			addChild(curveShape);
			generateCurve();
			
			tfHelp.textColor = 0xAAAAAA;
			tfHelp.autoSize = TextFieldAutoSize.LEFT;
			tfHelp.text = "[1-9] Degree / [C] Cage";
			tfHelp.mouseEnabled = false;
			addChild(tfHelp);
			
			tfStatus.textColor = 0xFFFFFF;
			tfStatus.autoSize = TextFieldAutoSize.LEFT;
			tfStatus.y = tfHelp.height;
			tfStatus.mouseEnabled = false;
			addChild(tfStatus);
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function generateCurve(numPoints:int = 6):void {
			var w:Number = stage.stageWidth;
			var h:Number = stage.stageHeight;
			var points:Array = new Array(numPoints);
			for (var i:int=0; i<numPoints; i++) {
				var handle:Handle = new Handle();
				var p:Point = new Point(50+Math.random()*(w-100), 50+Math.random()*(h-100));
				handle.point = p;
				addChild(handle);
				handle.x = p.x;
				handle.y = p.y;
				points[i] = p;
			}
			curve = new NurbsCurve(points);
			redraw();
		}	
		
		private function onMouseDown(e:MouseEvent):void {
			if (e.target is Handle) {
				currentHandle = e.target as Handle;
			}
		}
		
		private function onMouseUp(e:MouseEvent):void {
			currentHandle = null;
		}
		
		private function onMouseMove(e:MouseEvent):void {
			if (currentHandle) {
				currentHandle.x = mouseX;
				currentHandle.y = mouseY;
				currentHandle.point.x = mouseX;
				currentHandle.point.y = mouseY;
				redraw();
			}
		}
		
		private function onKeyDown(e:KeyboardEvent):void {
			var chr:String = String.fromCharCode(e.charCode);
			var num:int = int(chr);
			if (num > 0 && num < 10) {
				curve.setDegree(num);
				tfStatus.text = "Curve degree set to: "+num;
				redraw();
			} else 
			if (chr == "c") {
				cageVisible = !cageVisible;
				tfStatus.text = "Cage visible: "+cageVisible; 
				redraw();
			} else
			if (chr == "+") {
				if (samples < 1000) samples++;
				tfStatus.text = "Samples increased to: "+samples;
				redraw();
			} else
			if (chr == "-") {
				if (samples > 2) samples--;
				tfStatus.text = "Samples decreased to: "+samples;
				redraw();
			}
			
		}
		

		
		private function redraw():void {
			var g:Graphics = curveShape.graphics;
			var p:Point;
			var i:int;
			g.clear();
			
			// Draw cage
			if (cageVisible) {
				g.lineStyle(1,0x335588);
				p = curve.getCV(0);
				g.moveTo(p.x, p.y);
				for (i = 1; i<curve.getNumCVs(); i++) {
					p = curve.getCV(i);
					g.lineTo(p.x, p.y);
				}
			}
			
			// Draw curve
			g.lineStyle(1,0xFFFFFF);
			p = curve.getPoint(0);
			g.moveTo(p.x, p.y);
			for (i = 1; i<=samples; i++) {
				curve.getPoint(i/samples, p);
				g.lineTo(p.x, p.y);
			}
		}
		
	}
}
import flash.display.Sprite;
import flash.geom.Point;

class Handle extends Sprite {
	
	private static const radius:Number = 3;
	private static const pickRadius:Number = 6;
	
	public var point:Point;
	
	function Handle() {
		// Hotspot
		graphics.beginFill(0xFF0000,0);
		graphics.drawCircle(0,0,pickRadius);
		graphics.endFill();
		// Visible portion
		graphics.beginFill(0x00FF00);
		graphics.drawCircle(0,0,radius);
		graphics.endFill();
		
		buttonMode = true;
		useHandCursor = true;
	}
}
