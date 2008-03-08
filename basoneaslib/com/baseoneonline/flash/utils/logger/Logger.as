package com.baseoneonline.flash.utils.logger
{
	import flash.events.EventDispatcher;

	public class Logger extends EventDispatcher
	{
		
		private static var instance:Logger;
		private var filterLevel:int = LogLevel.DEBUG;
		private var enableTrace:Boolean = true;
		private var levelStrings:Array = ["DEBUG\t", "INFO\t", "WARN\t", "FATAL\t"];
		
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
		
		public function debug(n:String):void {
			fireLogEvent(n, LogLevel.DEBUG); 
		} 
		
		public function info(n:String):void {
			fireLogEvent(n, LogLevel.INFO); 
		}
		
		public function warn(n:String):void {
			fireLogEvent(n, LogLevel.WARN); 
		}
		
		public function fatal(n:String):void {
			fireLogEvent(n, LogLevel.FATAL); 
		}
		
		private function fireLogEvent(n:String, level:int):void {
			var e:LogEvent = new LogEvent(LogEvent.UPDATE);
			e.level = level;
			dispatchEvent(e);
			if (enableTrace) trace(levelStrings[level]+n);
		}
		
		public static function getInstance():Logger {
			if (!instance) instance = new Logger();
			return instance;
		}
		
	}
}