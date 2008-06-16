/*
MediaNode.as

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
package com.baseoneonline.flash.durin.vo
{
	import mx.collections.ArrayCollection;
	
	
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
		public var children:ArrayCollection = new ArrayCollection();
		
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
		
		public function hasChildren():Boolean {
			return children.length > 0;
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
