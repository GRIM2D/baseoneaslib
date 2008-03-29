/*

	KeyHandler

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
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.system.System;
	
	public class KeyHandler
	{
		
		
		private var stage:Stage;
		
		private var keysDown:Array = [];
		
		function KeyHandler(stage:Stage) {
			this.stage = stage;
			setEnabled(true);
		}
		
		public function setEnabled(b:Boolean):void {
			if (b) {
				stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			} else {
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			}
		}
		
		private function onKeyDown(e:KeyboardEvent):void {
			keysDown[e.keyCode] = true;
		}

		private function onKeyUp(e:KeyboardEvent):void {
			keysDown[e.keyCode] = null;
		}
		
		public function isDown(code:uint):Boolean {
			return (keysDown[code] != null);
		}

	}
}