/*
Logger.as

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
package com.baseoneonline.flash.utils.logger
{
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;

	[Event(name="update", type="com.baseoneonline.flash.utils.logger.LogEvent")]
	public class Logger extends EventDispatcher
	{
		
		private static var instance:Logger;
		private static var instances:Object = new Object();
		private var filterLevel:int = LogLevel.DEBUG;
		private var enableTrace:Boolean = true;
		private var levelStrings:Array = ["DEBUG\t", "INFO\t", "WARN\t", "FATAL\t"];
		private var className:String = "";
		
		public function Logger(className:String=null)
		{
			super();
			if (className) this.className = className;
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
		
		public function fatal(n:Object):void {
			fireLogEvent(n, LogLevel.FATAL); 
		}
		
		public static function debug(source:Object, n:Object):void {
			getInstance(source).debug(n);
		}
		public static function info(source:Object, n:Object):void {
			getInstance(source).info(n);
		}
		public static function warn(source:Object, n:Object):void {
			getInstance(source).warn(n);
		}
		public static function fatal(source:Object, n:Object):void {
			getInstance(source).fatal(n);
		}
		
		
		private function fireLogEvent(msg:Object, level:int):void {
			var n:String;
			if (!n) n = "NULL";
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
			
			if (instance) instance.dispatchEvent(e);
			for each(var log:Logger in instances) {
				log.dispatchEvent(e);
			}
			if (enableTrace) trace(e.levelString+className+"\n"+n);
		}
		
		
		
		public static function getInstance(id:*=null):Logger {
			if (id) {
				var className:String;
				if (id is String) className = id;
				else className = getQualifiedClassName(id);
				if (!instances[className]) instances[className] = new Logger(className);
				return instances[className];
			} else {
				if (!instance) instance = new Logger();
				return instance;
			}
		}
		
	}
}
