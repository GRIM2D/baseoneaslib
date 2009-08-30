package
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	
	public class Markers extends UIComponent
	{
		
		[Bindable]
		public var markers:ArrayCollection = new ArrayCollection();
		
		
		[Bindable]
		public var newMarkerColor:uint = 0xFFFFFF;
		
		private var cursor:Marker = new Marker();
		private var layer:Sprite = new Sprite();
		
		public function Markers()
		{
			addChild(layer);
			addChild(cursor);
			cursor.visible = false;
			enabled = false;
			
			addEventListener(Event.ADDED_TO_STAGE, function(e:Event):void {
				stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			});
		}
		
		private function onEnterFrame(e:Event):void {
			cursor.x = mouseX;
			cursor.y = mouseY;			
		}
		
		override public function set enabled(b:Boolean):void {
			super.enabled = b;
			if (b) {
				cursor.visible = true;
				addEventListener(Event.ENTER_FRAME, onEnterFrame);
				
			} else {
				cursor.visible = false;
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
				
		}
		
		private function placeMarker():void {
			var m:Marker = new Marker(newMarkerColor);
			m.x = mouseX;
			m.y = mouseY;
			layer.addChild(m);
			markers.addItem(m);
		}
		
		
		public function getBitmap():BitmapData {
			var bmpd:BitmapData = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0x000000);
			bmpd.draw(layer);
			return bmpd;
		}
		
		
		public function clear():void {
			while(layer.numChildren > 0) {
				layer.removeChildAt(0);
			}
			markers.removeAll();
		}
		
		private function onMouseUp(e:MouseEvent):void {
			if (enabled) {
				placeMarker();
			}
		}
		
		override public function get enabled():Boolean {
			return super.enabled;
		}

	}
}