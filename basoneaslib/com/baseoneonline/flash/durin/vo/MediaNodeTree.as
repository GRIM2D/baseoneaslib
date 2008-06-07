/*
MediaNodeTree.as

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
		
		private function retrieveChildrenOf(parentNode:MediaNode, a:Array):ArrayCollection {
			var b:Array = [];
			for (var i:int=0; i<a.length; i++) {
				var n:MediaNode = a[i];
				if (n.parentid == parentNode.id) {
					
					n.parent = parentNode;
					if (!n.children) n.children = new ArrayCollection();
					n.children = retrieveChildrenOf(n, a);
					b.push(n);
				}
			}
			return new ArrayCollection(b);
		}

	}
}
