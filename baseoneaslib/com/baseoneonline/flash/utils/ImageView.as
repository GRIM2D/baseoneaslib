package com.baseoneonline.flash.utils
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.utils.getQualifiedClassName;

	[Event(type="flash.events.Event", name="complete")]
	[Event(type="flash.events.ProgressEvent", name="progress")]
	public class ImageView extends Sprite
	{
		
		public static const SCALE_FIT:int = 0, SCALE_CROP:int = 1;
		
		private var _fill:Boolean = false;
		
		private var w:Number = 160;
		private var h:Number = 160;
		
		private var bmp:Bitmap;
		
		private var _mode:int = SCALE_FIT;
		
		private var _mask:Shape;
		
		public function ImageView()
		{
		}
		
		/**
		 * True will scale and crop the image to fit the frame,
		 * false will scale fit to show the entire image 
		 * 
		 */
		public function set mode(n:int):void {
			_mode = n;
			
			
			if (n == SCALE_CROP)  {
				if (!_mask) createMask();
				mask = _mask;
				mask.visible = true;
			} else {
				mask = null;
				mask.visible = false;
			}
		}
		
		
		
		public function get mode():int{
			return _mode;
		}
		
		
		
		public function set source(src:Bitmap):void {
			if (bmp) removeChild(bmp);
			bmp = src;
			addChild(bmp);
			resize();
		}
		
		
		public function setSize(w:Number, h:Number):void {
			this.w = w;
			this.h = h;
			resize();
		}
		
		private function resize():void {
			if (!bmp) return;
			
			var ir:Number = bmp.width/bmp.height;
			var tr:Number = w/h;
			
			var tw:Number = w;
			var th:Number = h;
			
			switch (_mode) {
				case SCALE_FIT:
					
					if (ir > tr) {
						th = tw / ir;
					} else {
						tw = th * ir;
					}
					
					break;
				case SCALE_CROP:
					
					if (ir > tr) {
						tw = th * ir;
					} else {
						th = tw / ir;
					}
					
					break;
				default:
					throw new Error("Wrong scale mode!");
			}
			
			bmp.width = tw;
			bmp.height = th;
			
			var tx:Number = w/2 - tw/2;
			var ty:Number = h/2 - th/2;
			
			bmp.x = tx;
			bmp.y = ty;

			if (mask) {
				mask.width = w;
				mask.height = h;
			}
			
		}
		
		private function createMask():void {
			_mask = new Shape();
			_mask.graphics.beginFill(0xFF0000);
			_mask.graphics.drawRect(0,0,100,100);
			_mask.graphics.endFill();
			addChild(_mask);
		}
		
	}
}