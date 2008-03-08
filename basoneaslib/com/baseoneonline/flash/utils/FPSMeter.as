/*

	FPSMeter

	Copyright (c) 2008 B Korsmit

    This file is part of BaseOne Actionscript 3 Library.

    BaseOne Actionscript 3 Library is free software: you can
    redistribute it and/or modify it under the terms of the
    GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License,
    or any later version.

    BaseOne Actionscript 3 Library is distributed
    in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
*/
package com.baseoneonline.flash.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	/**
	 * 	Very simple fps counter for everyday use.
	 * 
	 */
	public class FPSMeter extends Sprite
	{
		
		private var tf:TextField;
		private var bmp:BitmapData;
		private var tbmp:BitmapData;

		private var otime:int = 0;
		
		private var barWidth:int = 200;
		private var barHeight:int = 13;
		private var scrollWidth:int = 1;
		
		public function FPSMeter()
		{
			super();
			
			createAssets();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function createAssets():void
		{
			bmp = new BitmapData(barWidth, barHeight, false, 0x00FF00);
			addChild(new Bitmap(bmp));	
			
			tbmp = new BitmapData(scrollWidth,barHeight, false);
			
			tf = new TextField();
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.y = -4;
			addChild(tf);
		}
		
		
		private function onEnterFrame(e:Event):void
		{
			var ntime:int = getTimer();
			var ms:int = ntime - otime;
			otime = ntime;
			var fps:Number = 1000/ms;
			
			// Update the scroller
			bmp.scroll(-scrollWidth,0);
			var err:int = barHeight-Math.round((fps/stage.frameRate)*barHeight);
			var x:int; 
			var y:int;
			for (x=barWidth-scrollWidth; x<barWidth; x++) {
				for (y=0; y<err-1; y++) {
					bmp.setPixel(x,y,0xFF5500);	
				}
				for (y=err; y<barHeight; y++) {
					bmp.setPixel(x,y,0x00FF00);
				}
			}
			
			
			
			// Update text
			tf.text = "ms: "+ms+" | fps: "+fps.toFixed(1)+" / "+stage.frameRate;
			var fmt:TextFormat = new TextFormat();
			fmt.font = "_sans";
			tf.setTextFormat(fmt);
			
		}
		
		
		
		
		
	}
}