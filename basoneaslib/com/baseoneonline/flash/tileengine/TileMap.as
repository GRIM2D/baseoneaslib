/*
TileMap.as

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
package com.baseoneonline.flash.tileengine
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class TileMap
	{
		
		public var fgLayer:TileLayer;
		public var bgLayer:TileLayer;
		public var collision:CollisionLayer;
		
		public var width:uint;
		public var height:uint;
		
		public var tileWidth:uint;
		public var tileHeight:uint;
		
		
		private var tileset:Array = [];
		
		private var tilesetBitmap:Bitmap;
		public var tilesetWidth:uint;
		public var tilesetHeight:uint;
		
		function TileMap(w:uint, h:uint, tw:uint, th:uint) {
			width = w;
			height = h;
			tileWidth = tw;
			tileHeight = th;
			
			fgLayer = new TileLayer(w,h);
			bgLayer = new TileLayer(w,h);
			collision = new CollisionLayer(w,h);
		}
		
		public function getTile(tileID:uint):Tile {
			return tileset[tileID];
		}
		
		public function setSize(w:uint, h:uint):void {
			width = w;
			height = h;
			fgLayer.width = w;
			fgLayer.height = h;
			bgLayer.width = w;
			bgLayer.height = h;
			collision.width = w;
			collision.height = h;
		}
		
		public function setTilesize(w:uint, h:uint):void {
			tileWidth = w;
			tileHeight = h;
			rebuildTileset();
		}
		
		public function setTileset(b:Bitmap):void {
			tilesetBitmap = b;
			if (tilesetBitmap) rebuildTileset();
		}
		
		public function getTilesetBitmap():Bitmap {
			return tilesetBitmap;
		}
		
		private function rebuildTileset():void {
			tilesetWidth = Math.floor(tilesetBitmap.width/tileWidth);
			tilesetHeight = Math.floor(tilesetBitmap.height/tileHeight);
			tileset = new Array(tilesetWidth*tilesetHeight);
			var rect:Rectangle = new Rectangle(0,0,tileWidth,tileHeight);
			var i:uint = 0;
			var p:Point = new Point();
			for (var y:uint=0; y<tilesetHeight; y++) {
				for (var x:uint=0; x<tilesetWidth; x++) {
					rect.x = x*tileWidth;
					rect.y = y*tileHeight;
					var bmp:BitmapData = new BitmapData(tileWidth,tileHeight);
					bmp.copyPixels(tilesetBitmap.bitmapData, rect, p);  
					tileset[i] = new Tile(i, bmp);
					i++;
				}
			}
		}

		
	}
}
