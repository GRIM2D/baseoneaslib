package com.baseoneonline.flash.durin
{
	public class ResultObject
	{
		
		public var success:Boolean;
		public var message:String;
		public var data:Object;
		
		function ResultObject(success:Boolean, message:String=null, data:Object=null) {
			this.success = success;
			this.message = message;
			this.data = data;
		}

	}
}