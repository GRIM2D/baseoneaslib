package com.baseoneonline.flash.durin.vo
{
	public class MediaNodeTree
	{
		
		[Bindable]
		public var rootNode:MediaNode = new MediaNode();
		
		[Bindable]
		public var list:Array;
		
		function MediaNodeTree(sourceData:Array=null, includeInvisible:Boolean=true) {
			if (sourceData) setObjectData(sourceData, includeInvisible);
		}

		public function setObjectData(a:Array, includeInvisible:Boolean=true):void {
			list = [];
			for each(var o:Object in a) {
				var node:MediaNode = new MediaNode(o);
				if (includeInvisible || node.visible) {
					list.push(node);
				}
			}
			list.sortOn("order", Array.NUMERIC);
			rootNode.children = retrieveChildrenOf(rootNode, list);
		}
		
		private function retrieveChildrenOf(parentNode:MediaNode, a:Array):Array {
			var b:Array = [];
			for (var i:int=0; i<a.length; i++) {
				var n:MediaNode = a[i];
				if (n.parentid == parentNode.id) {
					
					n.parent = parentNode;
					if (!n.children) n.children = [];
					n.children = retrieveChildrenOf(n, a);
					b.push(n);
				}
			}
			return b;
		}

	}
}