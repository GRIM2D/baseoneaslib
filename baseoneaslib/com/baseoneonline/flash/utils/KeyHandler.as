/*
KeyHandler.as

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
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	
	public class KeyHandler
	{
		private static var instance:KeyHandler;
		
		public var stage:Stage;
		
		private var keysDown:Array = [];
		
		function KeyHandler() {
			
		}
		
		public function set enabled(b:Boolean):void {
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
		
		public function isDown(code:uint, repeat:Boolean=true):Boolean {
			return (keysDown[code] != null);
		}
		
		public static function get inst():KeyHandler {
			if (!instance) instance = new KeyHandler();
			return instance;
		}

	}
}
