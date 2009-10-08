/*
LogView.as

	Copyright (c) 2008 Bas Korsmit

    This file is part of baseone_flashLib

    baseone_flashLib is free software: you can
    redistribute it and/or modify it under the terms of the
    GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License,
    or any later version.

    baseone_flashLib Library is distributed
    in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with baseone_flashLib  If not, see <http://www.gnu.org/licenses/>.
*/

package com.baseoneonline.flash.utils
{
	import com.baseoneonline.flash.utils.logger.LogEvent;
	import com.baseoneonline.flash.utils.logger.Logger;
	
	import flash.display.Sprite;

	public class LogView extends Sprite
	{
		
		private var logger:Logger = Logger.getInstance();
		private var maxLines:int = 10;
		private var lines:Array = [];
		
		function LogView() {
			logger.addEventListener(LogEvent.UPDATE, onLogUpdate);
		}
		
		public function setMaxLines(n:int):void {
			maxLines = n;
		}
		
		private function onLogUpdate(e:LogEvent):void {
			addLine(e.message);
		}
		
		private function addLine(n:String):void {
			var ln:ShadowedTextField;
			if (lines.length+1 > maxLines) {
				ln = lines.shift();
				removeChild(ln);
			}
			
			ln = new ShadowedTextField();
			ln.setText(n); 
			addChild(ln);
			lines.push(ln);
			
			var y:Number = 0;
			for (var i:int=0; i<lines.length; i++) {
				ln = lines[i];
				ln.y = y;
				y += ln.height;
			}
		}
		
	}
}
	

