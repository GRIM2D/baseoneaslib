package com.baseoneonline.flash.utils.logger
{
	import flash.events.Event;

	public class LogEvent extends Event
	{
		
		public static const UPDATE:String = "update";
		
		
		public var level:int;
		
		public function LogEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		
		
	}
}