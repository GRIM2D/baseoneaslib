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
    along with BaseOne Actionscript 3 Library.  If not, see <http://www.gnu.org/licenses/>.
*/
package com.baseoneonline.flash.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	/**
	 * 	Very simple fps counter for everyday use.
	 * 
	 */
	public class FPSMeter extends Sprite
	{
		
		private var tf:ShadowedTextField;
		private var bmp:BitmapData;
		private var tbmp:BitmapData;

		private var otime:int = 0;
		
		private var barWidth:uint;
		private var barHeight:uint = 16;
		private var scrollWidth:int = 2;
		private var updateInterval:uint;
		private var count:uint = 0;
		private var ms:uint = 0;
		
		/**
		 * 
		 * 	@param	updateInterval	The number of frames to wait before updating
		 * 	@param	barWidth	The width of the graph.
		 */
		public function FPSMeter(updateInterval:uint=10, barWidth:uint=30)
		{
			this.updateInterval = updateInterval;
			this.barWidth = barWidth;
			createAssets();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function createAssets():void
		{
			bmp = new BitmapData(barWidth, barHeight, false, 0x00FF00);
			addChild(new Bitmap(bmp));	
			tbmp = new BitmapData(scrollWidth,barHeight, false);
			tf = new ShadowedTextField();
			tf.x = barWidth;
			tf.y = -3;
			addChild(tf);
		}
		
		
		private function onEnterFrame(e:Event):void
		{
			if (count < updateInterval) {
				count++;
			} else {
				var d:uint = getTimer()-ms;
				var msf:Number = d/updateInterval;
				var fps:Number = 1000/msf;


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
				tf.setText("ms "+msf.toFixed(1)+"  FPS: "+fps.toFixed(1)+"  /  "+stage.frameRate);

				
				// Reset
				count = 0;
				ms = getTimer();


			}
			
			
		}
		
		
		
		
		
	}
}