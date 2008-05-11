package com.baseoneonline.flash.durin.vo
{
	
	[Bindable]
	public class MediaNode
	{
		
		public var id:int;
		public var parentid:int;
		public var order:int;
		
		public var label:String;
		public var description:String;
		public var text:String;
		
		public var location:String;
		public var preview:String;
		public var thumbnail:String;
		
		public var type:String;
		
		public var visible:Boolean;
		
		public var parent:MediaNode;
		public var children:Array;
		
		function MediaNode(o:Object=null)
		{
			if (o!=null) {
				id = o.id;
				parentid = o.parentid;
				order = o.order;
				label = o.label;
				description = o.description;
				text = o.text;
				location = o.location;
				visible = (o.visible == 1) ? true : false;
				preview = o.preview;
				thumbnail = o.thumbnail;
				type = o.type;
			} else {
				id = 0;
				label = "[ROOT]";
				visible = true;
			}
		}
		
		public function getObject():Object {
			return {
				id:id,
				parentid:parentid,
				order:order,
				label:label,
				description:description,
				text:text,
				location:location,
				preview:preview,
				thumbnail:thumbnail,
				type:type,
				visible:visible?1:0
			}
		}
		
		
	}
}