/*

	Tilemap

	Copyright (c) 2008 B Korsmit

    This file is part of BaseOne Actionscript 3 Library.

    BaseOne Actionscript 3 Library is free software: you can
    redistribute it and/or modify it under the terms of the
    GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License,
    or any later version.

    BaseOne Actionscript 3 Library is distributed
    in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with BaseOne Actionscript 3 Library.  If not, see <http://www.gnu.org/licenses/>.
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
		private var tileRect:Rectangle;
		
		function TileMap(w:uint, h:uint, tw:uint, th:uint) {
			width = w;
			height = h;
			
			fgLayer = new TileLayer(w,h);
			bgLayer = new TileLayer(w,h);
			collision = new CollisionLayer(w,h);
		}
		
		public function getTile(tileID:uint):Tile {
			return tileset[tileID];
		}
		
		public function setTilesize(w:uint, h:uint):void {
			tileWidth = w;
			tileHeight = h;
			tileRect.width = w;
			tileRect.height = h;
			rebuildTileset();
		}
		
		public function setTileset(b:Bitmap):void {
			tilesetBitmap = b;
			//rebuildTileset();
		}
		
		public function getTilesetBitmap():Bitmap {
			return tilesetBitmap;
		}
		
		private function rebuildTileset():void {
			tilesetWidth = Math.floor(tilesetBitmap.width/tileWidth);
			tilesetHeight = Math.floor(tilesetBitmap.height/tileHeight);
			tileset = new Array(tilesetWidth*tilesetHeight);
			var i:uint = 0;
			var p:Point = new Point();
			for (var y:uint=0; y<tilesetHeight; y++) {
				for (var x:uint=0; x<tilesetWidth; x++) {
					tileRect.x = x*tileWidth;
					tileRect.y = y*tileHeight;
					var bmp:BitmapData = new BitmapData(tileWidth,tileHeight);
					bmp.copyPixels(tilesetBitmap.bitmapData, tileRect, p);  
					tileset[i] = new Tile(i, bmp);
					i++;
				}
			}
		}

		
	}
}