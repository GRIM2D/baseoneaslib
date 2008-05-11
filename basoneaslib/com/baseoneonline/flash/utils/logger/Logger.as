/*

	Logger

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
package com.baseoneonline.flash.utils.logger
{
	import flash.events.EventDispatcher;

	[Event(name="update", type="com.baseoneonline.flash.utils.logger.LogEvent")]
	public class Logger extends EventDispatcher
	{
		
		private static var instance:Logger;
		private static var instances:Object = new Object();
		private var filterLevel:int = LogLevel.DEBUG;
		private var enableTrace:Boolean = true;
		private var levelStrings:Array = ["DEBUG\t", "INFO\t", "WARN\t", "FATAL\t"];
		private var className:String = "";
		
		public function Logger()
		{
			super();
			
		}
		
		public function setFilterLevel(n:int):void {
			filterLevel = n;
		}
		
		public function setTrace(b:Boolean):void {
			enableTrace = b;
		}
		
		public function debug(n:Object):void {
			fireLogEvent(n, LogLevel.DEBUG); 
		} 
		
		public function info(n:Object):void {
			fireLogEvent(n, LogLevel.INFO); 
		}
		
		public function warn(n:Object):void {
			fireLogEvent(n, LogLevel.WARN); 
		}
		
		public function fatal(n:String):void {
			fireLogEvent(n, LogLevel.FATAL); 
		}
		
		private function fireLogEvent(msg:Object, level:int):void {
			var n:String;
			if (msg) {
				if (msg is String) {
					n = msg as String;
				} else {
					n = msg.toString();
				}
			} else {
				msg = "";
			}
			var e:LogEvent = new LogEvent(LogEvent.UPDATE);
			e.level = level;
			e.message = n;
			e.levelString = levelStrings[level];
			e.className = className;
			
			dispatchEvent(e);
			for each(var l:Logger in instances) {
				l.dispatchEvent(e);
			}
			if (enableTrace) trace(e.levelString+className+":: "+n);
		}
		
		
		public static function getInstance(className:String=null):Logger {
			if (className) {
				if (!instances[className]) instances[className] = new Logger();
				return instances[className];
			} else {
				if (!instance) instance = new Logger();
				return instance;
			}
		}
		
	}
}