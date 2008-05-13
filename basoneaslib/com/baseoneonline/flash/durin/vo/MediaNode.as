package com.baseoneonline.flash.durin.vo
{
	
	[Bindable]
	public class MediaNode
	{
		
		public var id:int = 0;
		public var parentid:int;
		public var order:int = 0;
		
		public var label:String = "[ROOT]";
		public var description:String = "";
		public var text:String = "";
		
		public var location:String = "";
		public var preview:String = "";
		public var thumbnail:String = "";
		
		public var type:String = MediaType.NODE;
		
		public var visible:Boolean = true;
		
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
		
		
		public function toString():String {
			var s:String = "[MediaNode ";
			s += "id='"+id+"', ";
			s += "label='"+label+"', ";
			s += "parentid='"+parentid+"'";
			s += "]";
			return s;
		}
		
	}
}