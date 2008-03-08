/*

	StopWatch

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
	import flash.display.Sprite;
	import flash.utils.getTimer;

	public class StopWatch extends Sprite
	{
		
		private var startTime:int;
		private var tf:ShadowedTextField;
		private var preText:String;
		
		public function StopWatch(preText:String='')
		{
			this.preText = preText;
			
			tf = new ShadowedTextField();
			addChild(tf);
		}
		
		/**
		 *	Set the starttime (Start counting) 
		 */
		public function start():void
		{
			startTime = getTimer();
		}
		
		/**
		 * 	Return the elapsed time since <code>start()</code> was called.
		 */
		public function read():int
		{
			return getTimer()-startTime;
		}
		
		/**
		 * 	Read the elapsed time,
		 * 	and display it in the textfield.
		 */
		public function display():void
		{
			var t:int = read();
			tf.setText(preText+" "+t+" ms.");
		}
		
		
		
	}
}